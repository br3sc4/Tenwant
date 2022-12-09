//
//  MyAccomodations.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI
import CoreData

struct MyAccomodations: View {
    @State private var showingAddAccomodation = false
    @State private var searchText = ""
    @State private var favorites = 0
    @ScaledMetric var size = CGFloat(1)
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    private var accomodations: FetchedResults<Accomodation>

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
                
                GalleryView(accommodations: accomodations)
            }
                .navigationTitle("My Accomodations")
                .navigationBarTitleDisplayMode(.large)
                
            
            
                .toolbar(content: {
                    ToolbarItem(placement: .primaryAction){
                        Button(action: {
//                            showingAddAccomodation.toggle()
                            Accomodation.createNewAccommodation(viewContext: viewContext,
                                                                title: "Via Postica Maddalena 36",
                                                                contact: "+39 081 1929 7263",
                                                                description_text: "2 room Appartement 125m2 in Centro Storico",
                                                                rent_cost: 1200,
                                                                extra_cost: 70,
                                                                url: "https://www.idealista.it/de/immobile/25939751/", isFavourite: false)
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
