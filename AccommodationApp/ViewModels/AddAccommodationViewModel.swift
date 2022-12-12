//
//  AddAccommodationViewModel.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 11/12/22.
//

import Foundation
import CoreLocation
import _PhotosUI_SwiftUI

final class AddAccommodationViewModel: ObservableObject {
    @Published var photosPickerItems: [PhotosPickerItem] = []
    @Published var images: [Data] = []
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
    @Published var useCustomCoordinates: Bool = false
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    
    @Published private(set) var alertContent: AlertContent = AlertContent()
    @Published var showAlert: Bool = false
    
    private func addressCoordinates() async throws -> CLLocationCoordinate2D? {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.geocodeAddressString(address)
        print("ℹ️ - \(placemarks)")
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
    
    private enum GeocodingError: LocalizedError {
        case coordinatesNotFound(address: String)
        
        var errorDescription: String? {
            switch self {
            case .coordinatesNotFound(let address):
                return "Coordinates not found for address \"\(address)\". Be sure the address is correct and well formed."
            }
        }
    }
    
    func loadImages(_ photos: [PhotosPickerItem]) {
        Task {
            await withTaskGroup(of: Optional<Data>.self) { group in
                for photo in photos {
                    group.addTask {
                        return try? await photo.loadTransferable(type: Data.self)
                    }
                }

                let result = await group
                    .compactMap { $0 }
                    .reduce(into: [Data]()) { partialResult, data in
                        partialResult.append(data)
                    }
                Task { @MainActor in
                    images = result
                }
            }
        }
    }
    
    func validateForm() -> Bool {
        !address.isEmpty && !latitude.isEmpty && !longitude.isEmpty && !rent.isEmpty
    }
    
    func presentAlert(title: String, message: String = "") {
        alertContent = AlertContent(title: title, message: message)
        showAlert = true
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
