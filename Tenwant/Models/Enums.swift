//
//  Enums.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 09/12/22.
//

import Foundation

enum Status: String, CaseIterable, Identifiable {
    case toContact = "to contact", toVisit = "to visit", filePreparation = "file preparation", fileSubmitted = "file submitted", bookingSubmitted = "booking submitted", awaitingReply = "awaiting reply", accepted, rejected
    var id: Self { self }
}

enum TypeOfAccomodation: String, CaseIterable, Identifiable {
    case singleRoom = "single room", sharedRoom = "shared room", studio, flat
    var id: Self { self }
}

enum TypeOfContact: String, CaseIterable, Identifiable {
    case individual, professional, platform
    var id: Self { self }
}
