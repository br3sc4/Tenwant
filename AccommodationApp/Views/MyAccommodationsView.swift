//
//  MyAccommodationsView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 10/12/22.
//

import SwiftUI
import CoreData

struct MyAccommodationsView: View {
    @State private var showingAddAccommodation = false
    @State private var searchText = ""
    @State private var favorites = 0
    @ScaledMetric var size = CGFloat(1)
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    private var accommodations: FetchedResults<Accomodation>

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
                
                if favorites == 0{
                    GalleryView(accommodations: accommodations)
                }
//                else if favorites == 1 {
//                    GalleryView(accommodations: accomodations)
//                }
            }
                .navigationTitle("My Accommodations")
                .navigationBarTitleDisplayMode(.large)
                .toolbar(content: {
                    ToolbarItem(placement: .primaryAction){
                        Button(action: {
                            showingAddAccommodation.toggle()
                        }, label: {
                            Image(systemName: "plus")
                            })
                    }
                }).sheet(isPresented: $showingAddAccommodation) {
                    AddAccommodationView()
                }
            
                
        }
        .searchable(text: $searchText, placement: .automatic)
    }
}

struct MyAccommodationsView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccommodationsView()
    }
}
