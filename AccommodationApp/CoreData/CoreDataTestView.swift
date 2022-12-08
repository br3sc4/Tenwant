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
            Button("Add Example"){
                let accomodation = Accomodation(context: viewContext)
                accomodation.id = UUID()
                accomodation.title = "Via Postica Maddalena 36"
                accomodation.contact = "+39 081 1929 7263"
                accomodation.description_text = "2 room Appartement 125m2 in Centro Storico"
                accomodation.extra_cost = 70
                accomodation.rent_cost = 1200
                accomodation.url = URL(string: "https://www.idealista.it/de/immobile/25939751/")
                accomodation.isFavourite = false
                try? viewContext.save()
            }
            List {
                ForEach(accomodations) { accomodation in
                    Text(accomodation.title!)
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
