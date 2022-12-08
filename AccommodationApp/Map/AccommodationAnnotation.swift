//
//  AccommodationAnnotation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import MapKit

enum AccommodationStatus {
case full, contacted, free
}

class AccommodationAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    let coordinate: CLLocationCoordinate2D
    var status: AccommodationStatus
    
    var location: String? {
        title
    }
    
    var markerColor: UIColor {
        switch status {
        case .free: return .green
        case .contacted: return .orange
        default: return .red
        }
    }
    
    init(title: String? = nil, subtitle: String? = nil, latitude: CLLocationDegrees, longitude: CLLocationDegrees, status: AccommodationStatus) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.status = status
        
        super.init()
    }
}
