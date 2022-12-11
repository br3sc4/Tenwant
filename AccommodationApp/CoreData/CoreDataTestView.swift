//
//  CoreDataTestView.swift
//  AccommodationApp
//
//  Created by Simon Bestler on 08.12.22.
//

import SwiftUI


struct CoreDataTestView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    private var accomodations: FetchedResults<Accomodation>

    
    var body: some View {
        VStack {
            /*
            Button("Add Example"){
                Accomodation.createNewAccommodation(viewContext: viewContext,
                                                    title: "Via Postica Maddalena 36",
                                                    contact: "+39 081 1929 7263",
                                                    description_text: "2 room Appartement 125m2 in Centro Storico",
                                                    rent_cost: 1200,
                                                    extra_cost: 70,
                                                    url: "https://www.idealista.it/de/immobile/25939751/", isFavourite: false, scheduled_appointment: Date.now)
            }
             */
            List {
                ForEach(accomodations) { accomodation in
                    Text(accomodation.wrappedTitle)
                }
            }
        }
    }
}

struct CoreDataTestView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTestView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
