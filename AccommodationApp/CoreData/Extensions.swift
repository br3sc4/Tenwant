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
    

    static func createNewAccommodation(viewContext : NSManagedObjectContext, title : String, contact : String, description_text : String, rent_cost : Int, extra_cost : Int, url: String, isFavourite: Bool){
        
        let newAccomodation = Accomodation(context: viewContext)
        newAccomodation.title = title
        newAccomodation.contact = contact
        newAccomodation.description_text = description_text
        newAccomodation.rent_cost = Int64(rent_cost)
        newAccomodation.url = URL(string: url)
        newAccomodation.isFavourite = isFavourite
        
        try? viewContext.save()
        
    }
    
    // Possiblity to make sure no optionals
    var wrappedTitle : String {
        title ?? ""
    }
    
    
}
