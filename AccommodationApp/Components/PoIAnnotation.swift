//
//  PoIAnnotation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 10/12/22.
//

import MapKit

final class PoIAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    let color: UIColor = .systemBlue
    
    let poi: PointOfInterest
    
    init(poi: PointOfInterest) {
        self.title = poi.name
        self.subtitle = poi.address
        self.coordinate = CLLocationCoordinate2D(latitude: poi.latitude, longitude: poi.longitude)
        self.poi = poi
    }
}
