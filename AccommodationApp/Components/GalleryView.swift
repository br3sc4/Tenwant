//
//  GalleryView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct GalleryView: View {
    let accommodations: FetchedResults<Accomodation>
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: gridItems, content: {
                ForEach(accommodations) { accommodation in
                   
                        NavigationLink(destination: ContentView(), label:
                                        {
                            AccomodationCardView(accommodation: accommodation)
                                .scaleEffect(0.80)
//                                .padding(EdgeInsets(top: 0, leading: 10, bottom: -30, trailing: 10))
                    })
                }
            })
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    static private var accomodations: FetchedResults<Accomodation>
    
    static var previews: some View {
        GalleryView(accommodations: accomodations)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
