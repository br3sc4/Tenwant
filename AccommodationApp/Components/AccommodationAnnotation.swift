//
//  AccommodationAnnotation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import MapKit

class AccommodationAnnotation: NSObject, MKAnnotation {
    var title: String?
    let coordinate: CLLocationCoordinate2D
    
    let accommodation: Accomodation
    
    init(accommodation: Accomodation) {
        self.title = accommodation.title
        self.coordinate = CLLocationCoordinate2D(latitude: accommodation.latitude, longitude: accommodation.longitude)
        self.accommodation = accommodation
        super.init()
    }
    
    var color: UIColor {
        guard let accommodationStatus = accommodation.status,
                let status = Status(rawValue: accommodationStatus) else { return .systemRed }
        
        switch status {
        case .rejected:
            return.systemRed
        case .toContact, .awaitingReply:
            return .systemOrange
        case .toVisit, .filePreparation, .fileSubmitted, .bookingSubmitted:
            return .systemYellow
        case .accepted:
            return .systemGreen
        }
    }
}
