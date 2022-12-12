//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI


struct AccommodationDetailsView: View {
    @StateObject private var vm: AccommodationDetailViewModel
    @Environment(\.openURL) var openURL
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var IsOn = false
    @State var isOnAddAppointment = false
    
    
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
            
            
            Section("") {
                ZStack{
                    HStack{
                        Button(action: {
                            vm.accommodation.isFavourite.toggle()
                            guard let _ = try? viewContext.save() else { return }
                            vm.isFavourite.toggle()
                        }, label: {
                            VStack(spacing: 3){
                                
                                Image(systemName: vm.isFavourite ? "heart.fill" : "heart")
                                    .foregroundColor(.accentColor)
                                
                                Text(vm.isFavourite ? "unfavourite" : "favorite")
                                    .font(.system(size: 11))
                                    .font(.subheadline)
                            }
                            .frame(width: 50, height: 50)
                        }).buttonStyle(BorderedButtonStyle())
                        
                        Spacer()
                        
                        if let _ = vm.phoneNumber,
                           let url = vm.phoneNumberUrl{
                            Button(action: {
                                UIApplication.shared.open(url)
                            }, label: {
                                VStack(spacing: 3){
                                    Image(systemName: "phone")
                                        .foregroundColor(.accentColor)
                                    
                                    Text("call")
                                        .font(.system(size: 11))
                                        .font(.subheadline)
                                }.frame(width: 55, height: 50)
                                
                            }).buttonStyle(BorderedButtonStyle())
                            
                            Spacer()
                        } else {
                            Button(action: {
                                
                            }, label: {
                                VStack(spacing: 3){
                                    Image(systemName: "phone")
                                        .foregroundColor(.secondary)
                                    
                                    Text("call")
                                        .font(.system(size: 11))
                                        .font(.subheadline)
                                }.frame(width: 55, height: 50)
                                
                            }).buttonStyle(BorderedButtonStyle())
                                .disabled(true)
                            
                            Spacer()
                        }
                        
                        
                        
                        
                        Button(action: {
                            isOnAddAppointment.toggle()
                        }, label: {
                            VStack(spacing: 3){
                                Image(systemName: "calendar")
                                    .foregroundColor(.accentColor)
                                
                                Text("add")
                                    .font(.system(size: 11))
                                    .font(.subheadline)
                            }.frame(width: 55, height: 50)
                            
                        }).buttonStyle(BorderedButtonStyle())
                            .sheet(isPresented: $isOnAddAppointment) {
                                AddAppointmentSheetView(accommodation: vm.accommodation)
                                    .presentationDetents([.medium])
                            }
                        
                        
                        Spacer()
                        
                        Button(role: .destructive , action: {
                            Accomodation
                                .deleteAccommodation(viewContext: viewContext, accommodationObject: vm.accommodation)
                            dismiss()
                        }, label: {
                            VStack(spacing: 3){
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                Text("delete")
                                    .foregroundColor(.red)
                                    .font(.system(size: 11))
                                    .font(.subheadline)
                            }.frame(width: 55, height: 50)
                        }).buttonStyle(BorderedButtonStyle())
                        
                    }
                }.listRowBackground(Color(UIColor.systemBackground))
                //                .listRowBackground(Color(UIColor.systemBackground))
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
            
            if let phoneNumber = vm.phoneNumber {
                Section("Contact") {
                    if let contactType = vm.contactType {
                        LabeledContent("Type", value: contactType)
                    }
                    if let contactName = vm.contactName {
                        LabeledContent("Name", value: contactName)
                    }
                    if let url = vm.phoneNumberUrl {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }, label: {
                            LabeledContent("Phone", value: phoneNumber)
                        }).buttonStyle(PlainButtonStyle())
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
