//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI


struct AccommodationDetailsView: View {
    @StateObject private var vm: AccommodationDetailViewModel
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
                .listRowInsets(EdgeInsets())
            }
            
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
            
            if let contactType = vm.contactType,
               let contactName = vm.contactName,
               let phoneNumber = vm.phoneNumber,
               let url = vm.phoneNumberUrl {
                Section("Contact") {
                    LabeledContent("Type", value: contactType)
                    LabeledContent("Name", value: contactName)
                    LabeledContent("Phone") {
                        Link(phoneNumber, destination: url)
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
            
            Section {
                Button {
                    vm.accommodation.isFavourite.toggle()
                    guard let _ = try? viewContext.save() else { return }
                    vm.isFavourite.toggle()
                } label: {
                    if vm.isFavourite {
                        Label("Unfavourite", systemImage: "heart.fill")
                    } else {
                        Label("Add to Favourites", systemImage: "heart")
                    }
                }
            }
        }
        .navigationTitle(vm.address)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button {
            //                    ShareLink(item: "hello")

                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
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
