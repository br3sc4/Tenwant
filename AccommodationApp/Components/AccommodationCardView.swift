//
//  AccommodationCardView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI
import CoreData

struct AccommodationCardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var accommodation: Accomodation
    
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(14)
                .shadow(radius: 2)
                .frame(width: 178, height: 228)
            
            
            VStack(alignment: .leading) {
                if let cardCover = accommodation.card_cover,
                   let uiImage = UIImage(data: cardCover) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 178, height: 173)
                        .scaledToFill()
                        
                    
                    
                } else {
                    Image("ph1")
                        .resizable()
                        .frame(width: 178, height: 173)
                        .scaledToFill()
                        
                }
                Spacer()

                Text(accommodation.wrappedTitle)
                    .lineLimit(1)
                    .foregroundColor(.accentColor)
                    .font(.system(size: 16))
                    .padding([.leading, .trailing], 10)
                    
                
                HStack {
                    Text(accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                        .foregroundColor(.secondary)
                        .font(.system(size: 16))
                        .padding(.leading, 10)
                    Spacer()
                    Button(action: {
                        Accomodation.toggleFavouriteAccommodation(viewContext: viewContext, accommodationObject: accommodation)
                        
                    }, label: {
                        
                        Image(systemName: accommodation.isFavourite ? "heart.fill" : "heart")
                    }).padding(.trailing, 10)
                }
            }
            .frame(width: 178, height: 228-18)
            //            .frame(width: 183, height: 235 - 18)
            .padding(.bottom, 18)
        }
        .mask(Rectangle()
            .frame(width: 180, height: 230)
            .cornerRadius(14)
              //                .shadow(radius: 2)
        )
    }
}
struct AccommodationCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationCardView(accommodation: .init())
    }
}
