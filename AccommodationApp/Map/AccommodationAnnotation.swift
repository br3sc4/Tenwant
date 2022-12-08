//
//  AccommodationAnnotation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import MapKit

class AccommodationAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    var color: UIColor?
    var location: String? {
        title
    }
    
    init(accommodation: Accommodation) {
        self.title = accommodation.address
        self.subtitle = accommodation.price.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
        self.coordinate = accommodation.coordinates
        super.init()
        
        self.color = markerColor(for: accommodation.status)
    }
    
    private func markerColor(for status: Accommodation.Status) -> UIColor {
        switch status {
        case .free: return .green
        case .contacted: return .orange
        default: return .red
        }
    }
}
