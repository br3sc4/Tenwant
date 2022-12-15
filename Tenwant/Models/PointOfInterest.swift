//
//  PointOfInterest.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 10/12/22.
//

import Foundation
import CoreLocation
import CoreData

extension PointOfInterest {
    //Sets ID automatically, when new Accomodation is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }

    @discardableResult
    static func makePointOfInterest(viewContext: NSManagedObjectContext,
                                    name: String,
                                    address: String,
                                    latitude: CLLocationDegrees,
                                    longitude: CLLocationDegrees) -> PointOfInterest {
        let poi = PointOfInterest(context: viewContext)
        poi.name = name
        poi.address = address
        poi.latitude = latitude
        poi.longitude = longitude
        
        try? viewContext.save()
        return poi
    }
}

extension PointOfInterest {
    static let cumanaFuorigrotta = PointOfInterest
        .makePointOfInterest(viewContext: PersistenceController.preview.viewContext,
                             name: "Cumana Fuorigrotta",
                             address: "Via Pippo",
                             latitude: 40.827930,
                             longitude: 14.201792)
    
    static let pois = [
        cumanaFuorigrotta
    ]
}
