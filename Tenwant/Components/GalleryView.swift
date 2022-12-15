//
//  GalleryView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct GalleryView: View {
    let accommodations: FetchedResults<Accomodation>
    private let gridItems = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: gridItems, spacing: 15) {
                ForEach(accommodations) { accommodation in
                    NavigationLink {
                        AccommodationDetailsView(accommodation: accommodation)
                        
                    } label: {
                        AccommodationCardView(accommodation: accommodation,
                                              isFavourite: accommodation.isFavourite)
                            .padding([.leading, .trailing], 4)
                    }
                }
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    static private var accommodations: FetchedResults<Accomodation>
    
    static var previews: some View {
        GalleryView(accommodations: accommodations)
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
