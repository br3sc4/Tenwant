//
//  AccommodationDetailViewModel.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 12/12/22.
//

import Foundation

final class AccommodationDetailViewModel: ObservableObject {
    var images: [Data] {
        accommodation.wrappedPhotos.compactMap(\.image)
    }
    
    var address: String {
        accommodation.title ?? ""
    }
    
    var accommodationType: TypeOfAccomodation {
        TypeOfAccomodation(rawValue: accommodation.type ?? "") ?? .singleRoom
    }
    
    var isVisitable: Bool {
        accommodation.isVisitPossible
    }
    
    @Published var currentStatus: Status
    
    var rentCost: String {
        accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
    }
    
    var extraCosts: String {
        accommodation.extra_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
    }
    
    var deposit: String {
        accommodation.deposit.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
    }
    
    var agencyFees: String {
        accommodation.agency_fee.formatted(.currency(code: "EUR").precision(.fractionLength(.zero)))
    }
    
    var contactName: String? {
        accommodation.contact_name
    }
    
    var phoneNumber: String? {
        accommodation.contact_phone
    }
    
    var phoneNumberUrl: URL? {
        guard let phoneNumber = accommodation.contact_phone else { return nil }
        let contactCleaned = phoneNumber.components(separatedBy: .whitespaces).joined()
        return URL(string: "tel://\(contactCleaned)")
    }
    
    var contactType: String? {
        accommodation.contact_type?.capitalized
    }
    
    @Published var isFavourite: Bool
<<<<<<< HEAD:Tenwant/ViewModels/AccommodationDetailViewModel.swift
    @Published var appointment: Date?
=======
>>>>>>> 94b9b29 (Refactored detail view & bug fix):AccommodationApp/ViewModels/AccommodationDetailViewModel.swift
    
    let accommodation: Accomodation
    
    init(accommodation: Accomodation) {
        self.isFavourite = accommodation.isFavourite
        self.currentStatus = Status(rawValue: accommodation.status ?? "") ?? .toContact
        self.accommodation = accommodation
<<<<<<< HEAD:Tenwant/ViewModels/AccommodationDetailViewModel.swift
        self.appointment =  accommodation.scheduled_appointment
=======
>>>>>>> 94b9b29 (Refactored detail view & bug fix):AccommodationApp/ViewModels/AccommodationDetailViewModel.swift
    }
}
