//
//  Status.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 09/12/22.
//

import Foundation

enum Status: String, CaseIterable, Identifiable {
    case toContact, toVisit, filePreparation, fileSubmitted, bookingSubmitted, awaitingReply, accepted, rejected
    var id: Self { self }
}
