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
    @State private var favourites = 0
    @ScaledMetric var size = CGFloat(1)
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.id, ascending: true)],
        animation: .default)
    private var accommodations: FetchedResults<Accomodation>

    var body: some View {
        NavigationStack{
            VStack{
                Picker("", selection: $favourites)
                {
                    Text("All").tag(0)
                    Text("Favourites").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(width: 200*size)
                
                if favourites == 0{
                    GalleryView(accommodations: accommodations)
                }
//                else if favourites == 1 {
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
