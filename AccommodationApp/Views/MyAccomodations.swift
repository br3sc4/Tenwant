//
//  MyAccomodations.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct MyAccomodations: View {
    
    @State private var searchText = ""
    @State private var favorites = 0
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("", selection: $favorites)
                {
                    Text("All").tag(0)
                    Text("Favorites").tag(1)
                    
                }
                .pickerStyle(.segmented)
                
                
                GalleryView()
            }
                .navigationTitle("My Accomodations")
                .navigationBarTitleDisplayMode(.large)
            
                .toolbar(content: {
                    ToolbarItem(placement: .primaryAction){
                        Button(action: {
                        }, label: {
                            Image(systemName: "plus")
                            })
                    }
                })
                
        }
        .searchable(text: $searchText)
        
    }
}

struct MyAccomodations_Previews: PreviewProvider {
    static var previews: some View {
        MyAccomodations()
    }
}
