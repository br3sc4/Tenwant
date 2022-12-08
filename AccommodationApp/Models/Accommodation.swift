//
//  Accommodation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import Foundation
import CoreLocation

struct Accommodation {
    let address: String
    let price: Double
    let status: Status
    let coordinates: CLLocationCoordinate2D
    
    init(address: String, price: Double, status: Status, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.address = address
        self.price = price
        self.status = status
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func distance(from location: CLLocation) -> Measurement<UnitLength> {
        let accommodation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let distance = accommodation.distance(from: location)
        print(distance)
        return Measurement(value: distance, unit: .meters)
    }
    
    enum Status: String {
        case full, contacted, free
    }
}
