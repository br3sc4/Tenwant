//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI


struct AccommodationDetailsView: View {
    
    @Environment(\.openURL) var openURL
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let accommodation: Accomodation
    
    @State var IsOn = false
    
    var body: some View {
        ScrollView{
            PhotosScrollView()
            Spacer()
            VStack(alignment: .leading){
                
                Text(accommodation.title ?? "")
                    .bold()
                    .foregroundColor(.primary)
                Text(accommodation.description_text ?? "")
                    .foregroundColor(.secondary)
                Spacer()
                
                AccommodationDetailsRow(key: "Address", value: accommodation.title ?? "title")
                
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "isFavourite", value: accommodation.isFavourite ? "true" : "else")
                    Button(action: {
                        Accomodation.toggleFavouriteAccommodation(viewContext: viewContext, accommodationObject: accommodation)
                    }, label: {
                        Image(systemName: accommodation.isFavourite ? "heart.fill" : "heart")
                    })
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "Contact", value: accommodation.contact_phone ?? "No contact provided")
                    Button(action: {
                        if let contact = accommodation.contact_phone {
                            let contactCleaned = contact.components(separatedBy: .whitespaces).joined()
                            let phone = "tel://"
                            let phoneNumberformatted = phone + contactCleaned
                            let url = URL(string: phoneNumberformatted)
                            UIApplication.shared.open(url!)
                        }
                    }, label: {
                        Image(systemName: "phone")
                    })
                }
                if let url = accommodation.url{
                    if let str = url.absoluteString {
                        ZStack(alignment: .trailing){
                            AccommodationDetailsRow(key: "external link",
                                                    value: str)
                            Button(action: {
                                openURL(url)
                            }, label: {
                                Image(systemName: "link")
                            })
                        }
                    }
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "possibilityToVisit", value: accommodation.isFavourite ? "" : "")
                        .padding(.trailing, 20)
                    Toggle("", isOn: $IsOn).toggleStyle(.switch)
                        .padding(.trailing, 20)
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "appointment", value: accommodation.scheduled_appointment?.formatted(date: .long, time: .omitted) ?? Date.now.formatted())
                    Button(action: {}, label: {
                        Image(systemName: "link")
                    })
                }
            }.padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 10))
        }
        .navigationTitle(accommodation.title ?? accommodation.wrappedTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button(action: {
                    //                    ShareLink(item: "hello")
                    
                }, label:
                        {
                    Image(systemName: "square.and.arrow.up")
                })
            }
            ToolbarItem(placement: .primaryAction){
                Button(action: {
                    Accomodation.deleteAccommodation(viewContext: viewContext, accommodationObject: accommodation)
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label:
                        {
                    Image(systemName: "trash")
                })
            }
        }
    }
}

struct AccommodationDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccommodationDetailsView(accommodation: .init())
    }
}
