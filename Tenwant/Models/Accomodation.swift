//
//  Accomodation.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 09/12/22.
//

import Foundation
import CoreLocation
import CoreData

extension Accomodation {
    func distance(from location: CLLocation) -> Measurement<UnitLength> {
        let accomodationLocation = CLLocation(latitude: latitude, longitude: longitude)
        return Measurement(value: location.distance(from: accomodationLocation),
                           unit: .meters)
    }
}

extension Accomodation {
    static let fuorigrotta: Accomodation = Accomodation
        .createNewAccommodation(viewContext: PersistenceController.preview.viewContext,
                                title: "Via Pietro Metastasio 47",
                                description_text: "",
                                rent_cost: "350",
                                extra_cost: "",
                                deposit: "",
                                agency_fee: "",
                                isVisitPossible: false,
                                url: "",
                                ownerName: "",
                                ownerPhoneNumber: "",
                                typeOfAccommodation: "",
                                scheduled_appointment: .now,
                                status: .accepted,
                                latitude: 40.832340,
                                longitude: 14.199398,
                                images: [])
    
    static let accommodations: [Accomodation] = [
        fuorigrotta
    ]
}
