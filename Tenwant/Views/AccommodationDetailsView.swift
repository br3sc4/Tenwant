//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI
import EventKit


struct AccommodationDetailsView: View {
    @StateObject private var accommodationVM: AccommodationDetailViewModel
//    @StateObject private var appointmentVM: AppointmentViewModel = AppointmentViewModel()
    @State var isOnAddAppointment = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    init(accommodation: Accomodation) {
        self._accommodationVM = StateObject(wrappedValue: AccommodationDetailViewModel(accommodation: accommodation))
    }
    
    var body: some View {
        List {
            if !accommodationVM.images.isEmpty {
                Section {
                    TabView {
                        ForEach(accommodationVM.images, id: \.self) { image in
                            if let uiImage = UIImage(data: image) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
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
                quickActions
            }
            .listRowBackground(Color.clear)
            
            Section("General") {
                LabeledContent("Type", value: accommodationVM.accommodationType.rawValue.capitalized)
                Toggle("Visitable", isOn: .constant(accommodationVM.isVisitable))
                    .disabled(true)
                Picker("Process Status", selection: $accommodationVM.currentStatus) {
                    ForEach(Status.allCases) { status in
                        Text(status.rawValue.capitalized).tag(status)
                    }
                }
                .onChange(of: accommodationVM.currentStatus) { status in
                    accommodationVM.accommodation.status = status.rawValue
                    try? viewContext.save()
                }
            }
            
            Section("Costs") {
                LabeledContent("Rent Cost", value: accommodationVM.rentCost)
                LabeledContent("Extra Costs", value: accommodationVM.extraCosts)
                LabeledContent("Deposit", value: accommodationVM.deposit)
                LabeledContent("Agency Fees", value: accommodationVM.agencyFees)
            }
            
            if let phoneNumber = accommodationVM.phoneNumber {
                Section("Contact") {
                    if let contactType = accommodationVM.contactType {
                        LabeledContent("Type", value: contactType)
                    }
                    if let contactName = accommodationVM.contactName {
                        LabeledContent("Name", value: contactName)
                    }
                    if let url = accommodationVM.phoneNumberUrl {
                        Button {
                            UIApplication.shared.open(url)
                        } label: {
                            LabeledContent("Phone", value: phoneNumber)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            

            if let description = accommodationVM.accommodation.description_text, !description.isEmpty {
                Section("Description") {
                    Text(description)
                }
            }
            
            if let url = accommodationVM.accommodation.url {
                Section {
                    LabeledContent("Advertisement URL") {
                        Link(url.formatted(), destination: url)
                    }
                }
            }
        }
        .navigationTitle(accommodationVM.address)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .primaryAction) {
                Button {
                    Accomodation
                        .deleteAccommodation(viewContext: viewContext, accommodationObject: accommodationVM.accommodation)
                    dismiss()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        
    }
    
    private var quickActions: some View {
        HStack {
            ActionButtonView(role: "isFavourite",
                             symbolName: accommodationVM.isFavourite ? "heart.fill" : "heart",
                             textLabel: accommodationVM.isFavourite ? "unfavourite".capitalized : "favorite".capitalized) {
                accommodationVM.accommodation.isFavourite.toggle()
                guard let _ = try? viewContext.save() else { return }
                accommodationVM.isFavourite.toggle()
            }
            Spacer()
            
            if let _ = accommodationVM.phoneNumber,
               let url = accommodationVM.phoneNumberUrl {
                    ActionButtonView(role: "default",
                                     symbolName: "phone",
                                     textLabel: "call") {
                        UIApplication.shared.open(url)
                    }
                Spacer()
            } else {
                ActionButtonView(role: "default",
                                 symbolName: "phone",
                                 textLabel: "call") {
                }
                .disabled(true)
                Spacer()
            }
            
            ActionButtonView(role: "default",
                             symbolName: "calendar",
                             textLabel: "add") {
                isOnAddAppointment.toggle()
            }
            .sheet(isPresented: $isOnAddAppointment) {
                if EKEventStore.authorizationStatus(for: .event) == .authorized || EKEventStore.authorizationStatus(for: .event) == .notDetermined {
                    AddAppointmentRepresentable()
                } else {
                    AddAppointmentView(vm: accommodationVM)
                }
            }
            
            Spacer()
           
            
            ActionButtonView(role: "delete",
                             symbolName: "trash",
                             textLabel: "delete") {
                Accomodation
                    .deleteAccommodation(viewContext: viewContext, accommodationObject: accommodationVM.accommodation)
                dismiss()
            }
        }
    }
    
}

struct AccommodationDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccommodationDetailsView(accommodation: Accomodation.fuorigrotta)
    }
}
