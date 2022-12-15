//
//  CalendarViewModel.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 15/12/22.
//

import Foundation


final class CalendarViewModel: ObservableObject {

    var address: String {
        accommodation.title ?? ""
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
    
    var appointment: Date? {
        accommodation.scheduled_appointment
    }
    
    let accommodation: Accomodation
    @Published var calendarData = [DateComponents?]()
    
    init(accommodation: Accomodation) {
        self.accommodation = accommodation
        var component = DateComponents()
        if let appointment = accommodation.scheduled_appointment {
            let scheduledAppointment = Calendar.current.dateComponents([.year, .month, .day, .timeZone], from: appointment)
            component.timeZone = scheduledAppointment.timeZone
            component.month = scheduledAppointment.month
            component.day = scheduledAppointment.day
            component.year = scheduledAppointment.year
            component.calendar = Calendar(identifier: .gregorian)
            calendarData.append(component)
        }
    }
    
    
    
    
//    func createCalendarData() -> [DateComponents] {
//        var data = [DateComponents]()
//        for accommodation in (accommodations, id: \.self.id) {
//            if let appointment = accommodation.scheduled_appointment {
//                let scheduledAppointment = Calendar.current.dateComponents([.year, .month, .day, .timeZone], from: appointment)
//                var component = DateComponents()
//                component.timeZone = scheduledAppointment.timeZone
//                component.month = scheduledAppointment.month
//                component.day = scheduledAppointment.day
//                component.year = scheduledAppointment.year
//                component.calendar = Calendar(identifier: .gregorian)
//
//                data.append(component)
//                print("added \(String(describing: component.date)) to the array")
//            }
//        }
//        return data
//    }

}
