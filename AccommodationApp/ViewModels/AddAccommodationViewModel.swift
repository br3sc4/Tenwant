//
//  AddAccommodationViewModel.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 11/12/22.
//

import Foundation
import CoreLocation

final class AddAccommodationViewModel: ObservableObject {
    @Published var address = ""
    @Published var description = ""
    @Published var rent  = ""
    @Published var extraCost = ""
    @Published var deposit = ""
    @Published var platformAgencyFees = ""
    @Published var possibilityToVisit = false
    @Published var dateOfVisit = Date.now
    @Published var hourOfVisit = Date.now
    @Published var urlAdvert = ""
    @Published var ownerFlatName = ""
    @Published var ownerFlatPhone = ""
    @Published var flatExtraDetails = ""
    @Published var selectedTypeOfAccomodation: TypeOfAccomodation = .singleRoom
    @Published var selectedTypeOfContact: TypeOfContact = .individual
    @Published var selectedStatus: Status = .toContact
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    
    @Published private(set) var alertContent: AlertContent = AlertContent()
    @Published var showAlert: Bool = false
    
    private func addressCoordinates() async throws -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        print(placemarks)
        guard let placemark = placemarks.first,
              let region = placemark.region as? CLCircularRegion else { return nil }
        
        return region.center
    }
    
    func getCoordinates() async {
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
    
    private enum GeocodingError: LocalizedError {
        case coordinatesNotFound(address: String)
        
        var errorDescription: String? {
            switch self {
            case .coordinatesNotFound(let address):
                return "Coordinates not found for address \"\(address)\". Be sure the address is correct and well formed."
            }
        }
    }
    
    enum TypeOfAccomodation: String, CaseIterable, Identifiable {
        case singleRoom = "single room", sharedRoom = "shared room", studio, flat
        var id: Self { self }
    }
    
    enum TypeOfContact: String, CaseIterable, Identifiable {
        case individual, professional, platform
        var id: Self { self }
    }
}
