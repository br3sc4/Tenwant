//
//  PointOfInterestViewModel.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 11/12/22.
//

import Foundation
import CoreLocation

final class PointOfInterestViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var address: String = ""
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
            Task { @MainActor in
                latitude = coordinates.latitude.formatted()
                longitude = coordinates.longitude.formatted()
            }
        } catch {
            print("❌ - \(error)")
            Task { @MainActor in
                presentAlert(title: error.localizedDescription)
            }
        }
    }
    
    func presentAlert(title: String, message: String = "") {
        alertContent = AlertContent(title: title, message: message)
        showAlert.toggle()
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
