//
//  Extensions.swift
//  AccommodationApp
//
//  Created by Simon Bestler on 08.12.22.
//

import Foundation
import CoreData

extension Accomodation {
    
        
    
    //Sets ID automatically, when new Accomodation is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }
    

    @discardableResult
    static func createNewAccommodation(viewContext : NSManagedObjectContext, title : String, contact : String, description_text : String, rent_cost : Int, extra_cost : Int, url: String, isFavourite: Bool, status: Status, latitude: Double = 0, longitude: Double = 0) -> Accomodation {
        
        let newAccomodation = Accomodation(context: viewContext)
        newAccomodation.title = title
        newAccomodation.contact = contact
        newAccomodation.description_text = description_text
        newAccomodation.rent_cost = Int64(rent_cost)
        newAccomodation.url = URL(string: url)
        newAccomodation.status = status.rawValue
        newAccomodation.isFavourite = isFavourite
        newAccomodation.latitude = latitude
        newAccomodation.longitude = longitude
        
        try? viewContext.save()
        return newAccomodation
    }
    
    // Possiblity to make sure no optionals
    var wrappedTitle : String {
        title ?? ""
    }
    
    
}
