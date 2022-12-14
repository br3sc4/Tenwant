//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI


struct AccommodationDetailsView: View {
    @StateObject private var vm: AccommodationDetailViewModel
    @State var isOnAddAppointment = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    init(accommodation: Accomodation) {
        self._vm = StateObject(wrappedValue: AccommodationDetailViewModel(accommodation: accommodation))
    }
    
    var body: some View {
        List {
            if !vm.images.isEmpty {
                Section {
                    TabView {
                        ForEach(vm.images, id: \.self) { image in
                            if let uiImage = UIImage(data: image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
//                                    .aspectRatio(4/3, contentMode: .fill)
                                    .clipShape(Rectangle())
                                    .tag(image.hashValue)
                            }
                        }
                    }
                    .tabViewStyle(.page)
                    .aspectRatio(4/3, contentMode: .fill)
                    .listRowInsets(EdgeInsets())
                }
                .listRowInsets(EdgeInsets())
            }
            
            Section {
                HStack{
                    
                    ActionButtonView(role: "isFavourite", symbolName: vm.isFavourite ? "heart.fill" : "heart",
                                     textLabel: vm.isFavourite ? "unfavourite".capitalized : "favorite".capitalized) {
                        vm.accommodation.isFavourite.toggle()
                        guard let _ = try? viewContext.save() else { return }
                        vm.isFavourite.toggle()
                    }
                    Spacer()
                    
                    if let _ = vm.phoneNumber,
                       let url = vm.phoneNumberUrl {
                            ActionButtonView(role: "default", symbolName: "phone",
                                             textLabel: "call") {
                                UIApplication.shared.open(url)
                            }
                        Spacer()
                    } else {
                        ActionButtonView(role: "default", symbolName: "phone",
                                         textLabel: "call") {
                        }
                        .disabled(true)
                        Spacer()
                    }
                    
                    ActionButtonView(role: "default",symbolName: "calendar",
                                     textLabel: "add") {
                        isOnAddAppointment.toggle()
                    }
                    .sheet(isPresented: $isOnAddAppointment) {
                        AddAppointmentSheetView(accommodation: vm.accommodation)
                            .presentationDetents([.medium])
                    }
                    
                    Spacer()
                   
                    
                    ActionButtonView(role: "delete", symbolName: "trash",
                                     textLabel: "delete") {
                        Accomodation
                            .deleteAccommodation(viewContext: viewContext, accommodationObject: vm.accommodation)
                        dismiss()
                    }
                }
            }
            .listRowBackground(Color.clear)
            
            Section("General") {
                LabeledContent("Type", value: vm.accommodationType.rawValue.capitalized)
                Toggle("Visitable", isOn: .constant(vm.isVisitable))
                    .disabled(true)
                Picker("Process Status", selection: $vm.currentStatus) {
                    ForEach(Status.allCases) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
                .onChange(of: vm.currentStatus) { status in
                    vm.accommodation.status = status.rawValue
                    try? viewContext.save()
                }
            }
            
            Section("Costs") {
                LabeledContent("Rent Cost", value: vm.rentCost)
                LabeledContent("Extra Costs", value: vm.extraCosts)
                LabeledContent("Deposit", value: vm.deposit)
                LabeledContent("Agency Fees", value: vm.agencyFees)
            }
            
            if let phoneNumber = vm.phoneNumber {
                Section("Contact") {
                    if let contactType = vm.contactType {
                        LabeledContent("Type", value: contactType)
                    }
                    if let contactName = vm.contactName {
                        LabeledContent("Name", value: contactName)
                    }
                    if let url = vm.phoneNumberUrl {
                        Button {
                            UIApplication.shared.open(url)
                        } label: {
                            LabeledContent("Phone", value: phoneNumber)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            

            if let description = vm.accommodation.description_text, !description.isEmpty {
                Section("Description") {
                    Text(description)
                }
            }
            
            if let url = vm.accommodation.url {
                Section {
                    LabeledContent("Advertisement URL") {
                        Link(url.formatted(), destination: url)
                    }
                }
            }
        }
        .navigationTitle(vm.address)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
//            ToolbarItem(placement: .primaryAction){
//                Button {
//                    //                    ShareLink(item: "hello")
//
//                } label: {
//                    Image(systemName: "square.and.arrow.up")
//                }
//            }
            
            ToolbarItem(placement: .primaryAction) {
                Button {
                    Accomodation
                        .deleteAccommodation(viewContext: viewContext, accommodationObject: vm.accommodation)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        
    }
    
}

struct AccommodationDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccommodationDetailsView(accommodation: Accomodation.fuorigrotta)
    }
}


struct AddAppointmentSheetView: View {
    @State var appointment = Date()
    @State private var isPresentingConfirm: Bool = false
    
    
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var vm: AccommodationDetailViewModel
    init(accommodation: Accomodation) {
        self._vm = StateObject(wrappedValue: AccommodationDetailViewModel(accommodation: accommodation))
    }
    
    var body: some View {
        
        DatePicker(
            "Pick a date",
            selection: $appointment,
            
            displayedComponents: [.date, .hourAndMinute])
        .padding()
        .datePickerStyle(.automatic)
        Spacer()
        HStack{
            Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            })
            
            Button(action: {
                Accomodation.bookAppointment(viewContext: viewContext, accommodationObject: vm.accommodation, newAppointment: appointment)
                dismiss()
            }, label: {
                Text("Save")
            })
        }
        
    }
}


