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
    var subtitle: String?
    
    let accommodation: Accomodation
    var userLocation: CLLocation
    
    init(accommodation: Accomodation) {
        self.title = accommodation.title
        self.coordinate = CLLocationCoordinate2D(latitude: accommodation.latitude, longitude: accommodation.longitude)
        self.accommodation = accommodation
        self.userLocation = CLLocation()
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
    
    func updateSubtitle() {
        subtitle = "\(priceFormatted) • \(distanceFormatted)"
    }
    
    private var priceFormatted: String {
        accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
    }
    
    private var distanceFormatted: String {
        accommodation.distance(from: userLocation)
            .formatted(.measurement(width: .abbreviated,
                                    usage: .road,
                                    numberFormatStyle: .number.precision(.fractionLength(.zero))))
    }
}
