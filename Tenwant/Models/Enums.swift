//
//  Enums.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 09/12/22.
//

import Foundation

enum Status: String, CaseIterable, Identifiable {
<<<<<<< HEAD:Tenwant/Models/Enums.swift
    case toContact = "to contact", toVisit = "to visit", filePreparation = "file preparation",
         fileSubmitted = "file submitted", bookingSubmitted = "booking submitted",
         awaitingReply = "awaiting reply", accepted, rejected
=======
    case toContact = "to contact", toVisit = "to visit", filePreparation = "file preparation", fileSubmitted = "file submitted", bookingSubmitted = "booking submitted", awaitingReply = "awaiting reply", accepted, rejected
>>>>>>> 94b9b29 (Refactored detail view & bug fix):AccommodationApp/Models/Enums.swift
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
