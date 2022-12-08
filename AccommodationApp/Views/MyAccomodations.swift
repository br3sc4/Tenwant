//
//  MyAccomodations.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct MyAccomodations: View {
    @State private var showingAddAccomodation = false
    @State private var searchText = ""
    @State private var favorites = 0
    @ScaledMetric var size = CGFloat(1)

    var body: some View {
        NavigationStack{
            VStack{
                Picker("", selection: $favorites)
                {
                    Text("All").tag(0)
                    Text("Favorites").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 200*size)
                
                GalleryView()
            }
                .navigationTitle("My Accomodations")
                .navigationBarTitleDisplayMode(.large)
                .toolbar(content: {
                    ToolbarItem(placement: .primaryAction){
                        Button(action: {
                            showingAddAccomodation.toggle()
                        }, label: {
                            Image(systemName: "plus")
                            })
                    }
                }).sheet(isPresented: $showingAddAccomodation) {
                    AddAccomodationView()
                }
        }
        .searchable(text: $searchText, placement: .automatic)
    }
}

struct MyAccomodations_Previews: PreviewProvider {
    static var previews: some View {
        MyAccomodations()
    }
}
