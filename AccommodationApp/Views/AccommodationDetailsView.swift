//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI

struct AccommodationDetailsView: View {
    
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
                ForEach(0..<4){ _ in
                    AccommodationDetailsRow(key: "Address", value: accommodation.title ?? "title")
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "isFavourite", value: accommodation.isFavourite ? "true" : "else")
                    Button(action: {}, label: {
                        Image(systemName: "heart")
                    })
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "external link", value: "provided")
                    Button(action: {}, label: {
                        Image(systemName: "link")
                    })
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow(key: "possibilityToVisit", value: accommodation.isFavourite ? "" : "")
                        .padding(.trailing, 20)
                    Toggle("", isOn: $IsOn).toggleStyle(.switch)
                        .padding(.trailing, 20)
                }
            }.padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 10))
        }
        .navigationTitle("Accommodation.title")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .primaryAction){
                Button(action: {
                    Accomodation.deleteAccommodation(viewContext: viewContext, accommodationObject: accommodation)
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label:
                        {
                    Text("Delete?")
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
