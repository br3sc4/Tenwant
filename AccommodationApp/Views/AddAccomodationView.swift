//
//  AddAccomodationView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI
import CoreData

struct AddAccomodationView: View {
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
    @State private var selectedTypeOfAccomodation: TypeOfAccomodation = .room
    @State private var selectedTypeOfContact: TypeOfContact = .individual
    
    enum TypeOfAccomodation: String, CaseIterable, Identifiable {
        case room, studio, entireFlat
        var id: Self { self }
    }
    enum TypeOfContact: String, CaseIterable, Identifiable {
        case individual, professional, bookingPlatform
        var id: Self { self }
    }
    @State private var selectedStatus: Status = .toContact

    
    
    var body: some View {
        
        NavigationView{
            Form {
                
                Group {
                    Section(header: Text("Address")) {
                        TextField("", text: $address)
                    }
                    Section(header: Text("Description")){
                        TextField("", text: $description )
                    }
                    Section(header: Text("Type of accomodation")) {
                        
                         List {
                             Picker("", selection: $selectedTypeOfAccomodation) {
                                 Text("Room in house to share").tag(TypeOfAccomodation.room)
                                 Text("Studio").tag(TypeOfAccomodation.studio)
                                 Text("Entire flat").tag(TypeOfAccomodation.entireFlat)
                             }
                         }
                    }
                    
                   
                    Section(header: Text("Rent")) {
                        TextField("",  text: $rent )
                    }
                    // - UPLOAD : Photo
                }
                
                Group {
                    Section(header: Text("Extra cost bills")) {
                        TextField("", text: $extraCost )
                    }
                    Section(header: Text("Deposit")) {
                        TextField("", text: $deposit )
                    }
                    Section(header: Text("Platform / Agency fees")) {
                        TextField("", text: $platformAgencyFees )
                    }
                    
                }
                
                Section(header: Text("Possibility to visit the room")) {
                    // - TOGGLE : possibility to visit the room
                    Toggle(""    , isOn: $possibilityToVisit)
                }
                
                
                Group {
                    Section(header: Text("Date of visit")) {
                        DatePicker("", selection: $dateOfVisit, displayedComponents: .date)
                    }
                    Section(header: Text("Hour of visit")) {
                        DatePicker("", selection: $hourOfVisit, displayedComponents: .hourAndMinute)
                    }
                    
                    
                    
                } // (Image(systemName: "calendar"))
                
                
                Group {
                    Section(header: Text("Link to the advert")) {
                        TextField("", text: $urlAdvert )
                    }
                    
                    Section(header: Text("Type of contact")) {
                        
                         List {
                             Picker("", selection: $selectedTypeOfContact) {
                                 Text("Individual").tag(TypeOfContact.individual)
                                 Text("Professional (real estate agency").tag(TypeOfContact.professional)
                                 Text("Booking platform").tag(TypeOfContact.bookingPlatform)
                             }
                         }
                    }
                    
                    Section(header: Text("Name of contact")) {
                        TextField("", text: $ownerFlatName)
                    }
                    Section(header: Text("Phone")) {
                        TextField("", text: $ownerFlatPhone)
                    }
                    
                    
                    Section(header: Text("Status")) {
                        
                         List {
                             Picker("", selection: $selectedStatus) {
                                 Text("To contact").tag(Status.toContact)
                                 Text("To Visit").tag(Status.toVisit)
                                 Text("File preparation").tag(Status.filePreparation)
                                 Text("File submitted").tag(Status.fileSubmitted)
                                 Text("Booking submitted").tag(Status.bookingSubmitted)
                                 Text("Awaiting reply").tag(Status.awaitingReply)
                                 Text("Accepted").tag(Status.accepted)
                                 Text("Rejected").tag(Status.rejected)
                                
                             }
                         }
                    }
                    
                    
                    
                    
                    // - LIST OF SINGLE SELECT : Status
                    Section(header: Text("Other")) {
                        TextField("", text: $flatExtraDetails)
                    }
                } // end of last Group
                

                
                
                
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
                            Accomodation.createNewAccommodation(viewContext: viewContext,
                                                                title: "Via Postica Maddalena 36",
                                                                contact: "+39 081 1929 7263",
                                                                description_text: "2 room Appartement 125m2 in Centro Storico",
                                                                rent_cost: 1200,
                                                                extra_cost: 70,
                                                                url: "https://www.idealista.it/de/immobile/25939751/",
                                                                isFavourite: false,
                                                                status: .accepted,
                                                                latitude: 40.852605,
                                                                longitude: 14.264905)
                            dismiss()
                        }, label:
                                {
                            Text("Add")
                        })
                    }
                }
        }
    }
}

struct AddAccomodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccomodationView()
    }
}
