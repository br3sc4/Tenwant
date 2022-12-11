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
    @StateObject private var vm: PointOfInterestViewModel = PointOfInterestViewModel()
    
    @FocusState private var focusedField: FocuseFields?
    @Environment(\.dismiss) private var dismiss: DismissAction
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $vm.name)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .name)
                        .onSubmit {
                            focusedField = .address
                        }
                    
                    TextField("Address", text: $vm.address)
                        .focused($focusedField, equals: .address)
                        .textContentType(.fullStreetAddress)
                        .submitLabel(.done)
                        .onSubmit {
                            focusedField = nil
                            Task {
                                await vm.getCoordinates()
                            }
                        }
                }
                
                Section("Coordinates") {
                    TextField("Latitude", text: $vm.latitude)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .latitude)
                        .onSubmit {
                            focusedField = .longitude
                        }
                    
                    TextField("Longitude", text: $vm.longitude)
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
            .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showAlert.toggle()
                }
            }
        }
    }
    
    private func savePoI() {
        Task {
            if vm.latitude.isEmpty || vm.longitude.isEmpty {
                await vm.getCoordinates()
            }
            
            guard let latitude = try? CLLocationDegrees(vm.latitude, format: .number),
                  let longitude = try? CLLocationDegrees(vm.longitude, format: .number) else { return }
            
            PointOfInterest.makePointOfInterest(viewContext: moc,
                                                name: vm.name,
                                                address: vm.address,
                                                latitude: latitude,
                                                longitude: longitude)
            
            dismiss()
        }
    }
    
    private enum FocuseFields {
        case name, address, latitude, longitude
    }
}

struct AddPoIView_Previews: PreviewProvider {
    static var previews: some View {
        AddPoIView()
    }
}
