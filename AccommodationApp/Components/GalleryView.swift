//
//  GalleryView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct GalleryView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: gridItems, content: {
                ForEach(0..<10){_ in
                   
                        NavigationLink(destination: ContentView(), label:
                            {AccomodationCardView()
                            .scaleEffect(0.80)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: -30, trailing: 10))
                    })
                }
            })
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
