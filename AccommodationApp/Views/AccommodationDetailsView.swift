//
//  AccommodationDetailsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI

struct AccommodationDetailsView: View {
    @State var IsOn = false
    
    var body: some View {
        ScrollView{
            PhotosScrollView()
            Spacer()
            VStack(alignment: .leading){
                
                Text("Title")
                    .bold()
                    .foregroundColor(.primary)
                Text("Description")
                    .foregroundColor(.secondary)
                Spacer()
                ForEach(0..<4){ _ in
                    AccommodationDetailsRow()
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow()
                    Button(action: {}, label: {
                        Image(systemName: "heart")
                    })
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow()
                    Button(action: {}, label: {
                        Image(systemName: "link")
                    })
                }
                ZStack(alignment: .trailing){
                    AccommodationDetailsRow()
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
                    
                }, label:
                        {
                    Text("Edit/Delete?")
                })
            }
        }
    }
}

struct AccommodationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationDetailsView()
    }
}
