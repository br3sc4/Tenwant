//
//  AddPoIView.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 10/12/22.
//

import SwiftUI
import CoreLocation
import CoreData

struct AddPoIView: View {
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    @State private var alertContent: AlertContent = AlertContent()
    @State private var showAlert: Bool = false
    @FocusState private var focusedField: FocuseFields?
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .name)
                        .onSubmit {
                            focusedField = .address
                        }
                    
                    TextField("Address", text: $address)
                        .focused($focusedField, equals: .address)
                        .textContentType(.fullStreetAddress)
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil
                            Task {
                                await getCoordinates()
                            }
                        }
                }
                
                Section("Coordinates") {
                    TextField("Latitude", text: $latitude)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .latitude)
                        .onSubmit {
                            focusedField = .longitude
                        }
                    
                    TextField("Longitude", text: $longitude)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .longitude)
                        .onSubmit {
                            focusedField = nil
                        }
                }
            }
            .navigationTitle("New Point of Interest")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Done", action: savePoI)
                }
            }
            .alert(alertContent.title, isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {
                    showAlert.toggle()
                }
            }
        }
    }
    
    private func addressCoordinates() async throws -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        print(placemarks)
        guard let placemark = placemarks.first,
              let region = placemark.region as? CLCircularRegion else { return nil }
        
        return region.center
    }
    
    private func getCoordinates() async {
        let task = Task {
            let coordinates = try await addressCoordinates()
            guard let coordinates else { throw GeocodingError.coordinatesNotFound(address: address) }
            
            return coordinates
        }
        
        let result = await task.result
        
        do {
            let coordinates = try result.get()
            latitude = coordinates.latitude.formatted()
            longitude = coordinates.longitude.formatted()
        } catch {
            print("❌ - \(error)")
            alertContent = AlertContent(title: error.localizedDescription)
            showAlert.toggle()
        }
    }
    
    private func savePoI() {
        Task {
            if latitude.isEmpty || longitude.isEmpty {
                await getCoordinates()
            }
            
            guard let latitude = try? CLLocationDegrees(latitude, format: .number),
                  let longitude = try? CLLocationDegrees(longitude, format: .number) else { return }
            
            PointOfInterest.makePointOfInterest(viewContext: moc,
                                                name: name,
                                                address: address,
                                                latitude: latitude,
                                                longitude: longitude)
            
            dismiss()
        }
    }
    
    private enum FocuseFields {
        case name, address, latitude, longitude
    }
    
    private enum GeocodingError: LocalizedError {
        case coordinatesNotFound(address: String)
        
        var errorDescription: String? {
            switch self {
            case .coordinatesNotFound(let address):
                return "Coordinates not found for address \"\(address)\". Be sure the address is correct and well formed."
            }
        }
    }
}

struct AddPoIView_Previews: PreviewProvider {
    static var previews: some View {
        AddPoIView()
    }
}
