//
//  AddAccommodationView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 10/12/22.
//

import SwiftUI
import CoreData
import CoreLocation

struct AddAccommodationView: View {
    @StateObject private var vm: AddAccommodationViewModel = AddAccommodationViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Accommodation") {
                    TextField("Address", text: $vm.address)
                    TextField("Description", text: $vm.description)
                    TextField("Article link", text: $vm.urlAdvert)
                    Picker("Type", selection: $vm.selectedTypeOfAccomodation) {
                        ForEach(AddAccommodationViewModel.TypeOfAccomodation.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    Picker("Status", selection: $vm.selectedStatus) {
                        ForEach(Status.allCases) { status in
                            Text(status.rawValue.capitalized).tag(status)
                        }
                    }
                    Toggle("Possibility to visit the room", isOn: $vm.possibilityToVisit)
                }
                // - UPLOAD : Photo
                
                Section("Costs") {
                    TextField("Rent cost",  text: $vm.rent)
                    TextField("Extra cost bills", text: $vm.extraCost)
                    TextField("Deposit", text: $vm.deposit)
                    TextField("Platform / Agency fees", text: $vm.platformAgencyFees)
                }
                
                Section("Contact") {
                    TextField("Name", text: $vm.ownerFlatName)
                    TextField("Phone", text: $vm.ownerFlatPhone)
                    Picker("Contact type", selection: $vm.selectedTypeOfContact) {
                        ForEach(AddAccommodationViewModel.TypeOfContact.allCases) { contactType in
                            Text(contactType.rawValue.capitalized).tag(contactType)
                        }
                    }
                }
                
                Section("Appointment") {
                    DatePicker("Date and Time", selection: $vm.dateOfVisit, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Coordinates") {
                    TextField("Latitude", text: $vm.latitude)
                    TextField("Longitude", text: $vm.longitude)
                }
                
                Section("Other") {
                    TextField("", text: $vm.flatExtraDetails)
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
                        saveAccommodation()
                    }, label:
                            {
                        Text("Save")
                    })
                }
            }
            .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showAlert.toggle()
                }
            }
        }
    }
    
    private func saveAccommodation() {
        Task {
            if vm.latitude.isEmpty || vm.longitude.isEmpty {
                await vm.getCoordinates()
            }
            
            guard let latitude = try? CLLocationDegrees(vm.latitude, format: .number),
                  let longitude = try? CLLocationDegrees(vm.longitude, format: .number) else { return }
            
            Accomodation.createNewAccommodation(
                viewContext: viewContext,
                title: vm.address,
                description_text: vm.description,
                rent_cost: vm.rent,
                extra_cost: vm.extraCost,
                deposit: vm.deposit,
                agency_fee: vm.platformAgencyFees,
                isVisitPossible: vm.possibilityToVisit,
                appointment_date: vm.dateOfVisit,
                url: vm.urlAdvert,
                ownerName: vm.ownerFlatName,
                ownerPhoneNumber: vm.ownerFlatPhone,
                typeOfAccommodation: vm.selectedTypeOfAccomodation.rawValue,
                scheduled_appointment: vm.dateOfVisit,
                status: vm.selectedStatus,
                latitude: latitude,
                longitude: longitude)
            
            dismiss()
        }
    }
}
struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
