//
//  AddAccommodationView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 10/12/22.
//

import SwiftUI

struct AddAccommodationView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var address = ""
    @State private var description = ""
    @State private var rent  = ""
    @State private var extraCost = ""
    @State private var deposit = ""
    @State private var platformAgencyFees = ""
    @State private var possibilityToVisit = false
    @State private var dateOfVisit = Date()
    @State private var hourOfVisit = Date()
    @State private var urlAdvert = ""
    @State private var ownerFlatName = ""
    @State private var ownerFlatPhone = ""
    @State private var flatExtraDetails = ""
    @State private var selectedTypeOfAccomodation: TypeOfAccomodation = .singleRoom
    @State private var selectedTypeOfContact: TypeOfContact = .individual
    
    enum TypeOfAccomodation: String, CaseIterable, Identifiable {
        case singleRoom = "single room", sharedRoom = "shared room", studio, flat
        var id: Self { self }
    }
    enum TypeOfContact: String, CaseIterable, Identifiable {
        case individual, professional, platform
        var id: Self { self }
    }
    enum Status: String, CaseIterable, Identifiable {
        case toContact = "to contact", toVisit = "to visit", filePreparation = "file preparation", fileSubmitted = "file submitted", bookingSubmitted = "booking submitted", awaitingReply = "awaiting reply", accepted, rejected
        var id: Self { self }
    }
    @State private var selectedStatus: Status = .toContact
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Accommodation") {
                    TextField("Address", text: $address)
                    TextField("Description", text: $description)
                    TextField("Article link", text: $urlAdvert)
                    Picker("Type", selection: $selectedTypeOfAccomodation) {
                        ForEach(TypeOfAccomodation.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    Picker("Status", selection: $selectedStatus) {
                        ForEach(Status.allCases) { status in
                            Text(status.rawValue.capitalized).tag(status)
                        }
                    }
                    Toggle("Possibility to visit the room", isOn: $possibilityToVisit)
                }
                // - UPLOAD : Photo
                
                Section("Costs") {
                    TextField("Rent cost",  text: $rent)
                    TextField("Extra cost bills", text: $extraCost)
                    TextField("Deposit", text: $deposit)
                    TextField("Platform / Agency fees", text: $platformAgencyFees)
                }
                
                Section("Contact") {
                    TextField("Name", text: $ownerFlatName)
                    TextField("Phone", text: $ownerFlatPhone)
                    Picker("Contact type", selection: $selectedTypeOfContact) {
                        ForEach(TypeOfContact.allCases) { contactType in
                            Text(contactType.rawValue.capitalized).tag(contactType)
                        }
                    }
                }
                
                Section("Appointment") {
                    DatePicker("Date and Time", selection: $dateOfVisit, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Other") {
                    TextField("", text: $flatExtraDetails)
                        .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("Add a new Accomodation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button(action: {
                        dismiss()
                    }, label:
                            {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {
                        Accomodation.createNewAccommodation(
                            viewContext: viewContext,
                            title: address,
                            description_text: description,
                            rent_cost: rent,
                            extra_cost: extraCost,
                            deposit: deposit,
                            agency_fee: platformAgencyFees,
                            isVisitPossible: possibilityToVisit,
                            appointment_date: dateOfVisit,
                            url: urlAdvert,
                            ownerName: ownerFlatName,
                            ownerPhoneNumber: ownerFlatPhone,
                            typeOfAccommodation: selectedTypeOfAccomodation.rawValue,
                            scheduled_appointment: dateOfVisit)
                        
                        dismiss()
                    }, label:
                            {
                        Text("Save")
                    })
                }
            }
        }
    }
}
struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
