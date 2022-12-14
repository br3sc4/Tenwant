//
//  AddAccommodationView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 10/12/22.
//

import SwiftUI
import CoreData
import CoreLocation
import PhotosUI

struct AddAccommodationView: View {
    @StateObject private var vm: AddAccommodationViewModel = AddAccommodationViewModel()
    @FocusState private var focusedField: FocusedField?
    @Environment(\.managedObjectContext) private var viewContext: NSManagedObjectContext
    @Environment(\.dismiss) var dismiss: DismissAction
    @State private var showConfirmationDialog: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    if !vm.images.isEmpty {
                        TabView {
                            ForEach(vm.images, id: \.self) { image in
                                if let uiImage = UIImage(data: image) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(4/3, contentMode: .fill)
                                        .clipShape(Rectangle())
                                        .tag(image.hashValue)
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .aspectRatio(4/3, contentMode: .fill)
                        .listRowInsets(EdgeInsets())
                    }
                    
                    PhotosPicker(vm.photosPickerItems.isEmpty ? "Select Images" : "Edit Images Selection",
                                 selection: $vm.photosPickerItems,
                                 selectionBehavior: .ordered,
                                 matching: .images)
                }
                .onChange(of: vm.photosPickerItems, perform: vm.loadImages)
                .listRowSeparator(.hidden)
                
                Section("Accommodation") {
                    TextField("Address (Required)", text: $vm.address)
                        .textContentType(.fullStreetAddress)
                        .focused($focusedField, equals: .address)
                    // test
                        .focused($keyboardIsFocused)
                    
                    Picker("Type", selection: $vm.selectedTypeOfAccomodation) {
                        ForEach(TypeOfAccomodation.allCases) { type in
                            Text(type.rawValue.capitalized).tag(type)
                        }
                    }
                    Picker("Status", selection: $vm.selectedStatus) {
                        ForEach(Status.allCases) { status in
                            Text(status.rawValue.capitalized).tag(status)
                        }
                    }
                    Toggle("Possibility to visit", isOn: $vm.possibilityToVisit)
                }
                
                Section("Coordinates") {
                    Toggle("Custom Coordinates", isOn: $vm.useCustomCoordinates)
                    if vm.useCustomCoordinates {
                        TextField("Latitude (Required)", text: $vm.latitude)
                            .focused($focusedField, equals: .latitude)
                            .keyboardType(.decimalPad)
                        TextField("Longitude (Required)", text: $vm.longitude)
                            .focused($focusedField, equals: .longitude)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section("Costs") {
                    TextField("Rent cost (Required)",  text: $vm.rent)
                        .focused($focusedField, equals: .rentCost)
                    // test
                        .focused($keyboardIsFocused)

                    TextField("Extra cost bills", text: $vm.extraCost)
                        .focused($focusedField, equals: .extraCosts)
                    // test
                        .focused($keyboardIsFocused)

                    TextField("Deposit", text: $vm.deposit)
                        .focused($focusedField, equals: .depositCost)
                    // test
                        .focused($keyboardIsFocused)

                    TextField("Platform / Agency fees", text: $vm.platformAgencyFees)
                        .focused($focusedField, equals: .agencyFees)
                    // test
                        .focused($keyboardIsFocused)

                }
                .keyboardType(.decimalPad)
                
                Section("Contact") {
                    TextField("Name", text: $vm.ownerFlatName)
                        .focused($focusedField, equals: .contactName)
                        .textContentType(.name)
                    // test
                        .focused($keyboardIsFocused)

                    TextField("Phone", text: $vm.ownerFlatPhone)
                        .focused($focusedField, equals: .contactPhone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                    // test
                        .focused($keyboardIsFocused)

                    Picker("Contact type", selection: $vm.selectedTypeOfContact) {
                        ForEach(TypeOfContact.allCases) { contactType in
                            Text(contactType.rawValue.capitalized).tag(contactType)
                        }
                    }
                }
                
                Section("Extra") {
                    TextField("Advertisment url", text: $vm.urlAdvert)
                        .focused($focusedField, equals: .advertisementUrl)
                        .textContentType(.URL)
                        .keyboardType(.URL)
                    // test
                        .focused($keyboardIsFocused)

                    
                    TextField("Description", text: $vm.description)
                        .focused($focusedField, equals: .description)
                        .multilineTextAlignment(.leading)
                    // test
                        .focused($keyboardIsFocused)

                }
            }
            .scrollDismissesKeyboard(.interactively)
            .interactiveDismissDisabled()
            .navigationTitle("Add a new Accomodation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .destructive){
                        if vm.formHasFilled {
                            showConfirmationDialog = true
                        } else {
                            dismiss()
                        }
                    }
                    .confirmationDialog("Are you sure you want to discard this accomodation?",
                                        isPresented: $showConfirmationDialog,
                                        titleVisibility: .visible) {
                         Button("Discard Changes", role: .destructive) {
                             dismiss()
                         }
                         Button("Keep Editing", role: .cancel) {}
                      }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveAccommodation)
                }
              // test
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        keyboardIsFocused = false
                    }
                }
                
            }
            
            
            .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showAlert.toggle()
                }
            } message: {
                Text(vm.alertContent.message)
            }
//            .onTapGesture {
//                guard focusedField != nil else { return }
//                withAnimation {
//                    focusedField = nil
//                }
//            }
        }
    }
    
    private func saveAccommodation() {
        Task {
            let task = Task {
                if !vm.useCustomCoordinates {
                    await vm.getCoordinates()
                }
            }
            
            let result = await task.result
            
            guard let _ = try? result.get() else { return }
            
            if vm.validateForm() {
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
                    url: vm.urlAdvert,
                    ownerName: vm.ownerFlatName,
                    ownerPhoneNumber: vm.ownerFlatPhone,
                    typeOfAccommodation: vm.selectedTypeOfAccomodation.rawValue,
                    scheduled_appointment: nil,
                    status: vm.selectedStatus,
                    latitude: latitude,
                    longitude: longitude,
                    images: vm.images)
                
                dismiss()
            } else {
                vm.presentAlert(title: "Invalid data",
                                message: "Check that all the required fields are filled correctly")
            }
        }
    }
    
    private enum FocusedField {
        case address, latitude, longitude, rentCost, extraCosts,
             depositCost, agencyFees, contactName, contactPhone,
             advertisementUrl, description
    }
}

struct AddAccommodationView_Previews: PreviewProvider {
    static var previews: some View {
        AddAccommodationView()
    }
}
