//
//  Extensions.swift
//  AccommodationApp
//
//  Created by Simon Bestler on 08.12.22.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

extension Accomodation {
            
    //Sets ID automatically, when new Accomodation is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue(false, forKey: "isFavourite")
    }
    
    func toogleFavourite() {
        self.isFavourite.toggle()
        try? self.managedObjectContext?.save()
        print(self.isFavourite)
    }
    
    static func searchPredicate(for search : String) -> NSPredicate {
        return NSPredicate(format: "title CONTAINS %@", search)
    }
    
    static func filterFavouritesRequest() -> NSFetchRequest<Accomodation> {
        let request = fetchRequest()
        let predicate = NSPredicate(format: "isFavourite == 1")
        let sortDescriptor = [NSSortDescriptor(keyPath: \Accomodation.id, ascending: true)]
        request.predicate = predicate
        request.sortDescriptors = sortDescriptor
        return request
    }
    
    @discardableResult
    static func createNewAccommodation(viewContext : NSManagedObjectContext,
                                       title : String,
                                       description_text : String,
                                       rent_cost : String,
                                       extra_cost : String,
                                       deposit : String,
                                       agency_fee : String,
                                       isVisitPossible : Bool,
                                       appointment_date : Date,
                                       url : String,
                                       ownerName : String,
                                       ownerPhoneNumber : String,
                                       typeOfAccommodation : String,
                                       isFavourite: Bool = false,
                                       scheduled_appointment: Date,
                                       status: Status,
                                       latitude: Double = 0,
                                       longitude: Double = 0,
                                       images: [Data]) -> Accomodation {
        
        let newAccomodation = Accomodation(context: viewContext)
        newAccomodation.title = title
        newAccomodation.description_text = description_text
        newAccomodation.rent_cost = Int64(rent_cost) ?? 0
        
        if extra_cost != "", let extra_cost = Int64(extra_cost) {
            newAccomodation.extra_cost = extra_cost
        }
        
        if deposit != "", let deposit = Int64(deposit) {
            newAccomodation.deposit = deposit
        }
        
        if agency_fee != "", let agency_fee = Int64(agency_fee){
            newAccomodation.agency_fee = agency_fee
        }
        
        newAccomodation.isVisitPossible = isVisitPossible
        
        newAccomodation.appointment?.date = appointment_date
        
        newAccomodation.url = URL(string: url)

        newAccomodation.status = status.rawValue
        newAccomodation.latitude = latitude
        newAccomodation.longitude = longitude
        
        if ownerName != "" {
            newAccomodation.contact_name = ownerName
        }
        
        if ownerPhoneNumber != "" {
            newAccomodation.contact_phone = ownerPhoneNumber
        }
        
        newAccomodation.type = typeOfAccommodation
        
        for image in images {
            let photo = Photo(context: viewContext)
            photo.image = image
            newAccomodation.addToPhotos(photo)
        }

        newAccomodation.isFavourite = isFavourite
        newAccomodation.scheduled_appointment = scheduled_appointment
        
        try? viewContext.save()
        return newAccomodation
    }
    
    // Possiblity to make sure no optionals
    var wrappedTitle : String {
        title ?? ""
    }
    
    var wrappedPhotos : [Photo] {
        return Photo.toArray(self.photos)
    }
    
    static func deleteAccommodation(viewContext : NSManagedObjectContext, accommodationObject: Accomodation){
        viewContext.delete(accommodationObject)
        
        try? viewContext.save()
    }
    
    static func toggleFavouriteAccommodation(viewContext : NSManagedObjectContext, accommodationObject: Accomodation){
        accommodationObject.isFavourite.toggle()
        try? viewContext.save()
    }
    
}

extension Appointment {
    //Sets ID automatically, when new Appointment is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }
}


extension Photo {
    //Sets ID automatically, when new Appointment is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }
    
    var wrappedImage : Image {
        if let image = self.image, let uiImage =  UIImage(data: image) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "photo")
    }
    
    public static func toArray(_ photos: NSSet?) -> [Photo] {
        if let photos = photos {
            return photos.allObjects as! [Photo]
        }
        else {
            return []
        }
    }
    
}


