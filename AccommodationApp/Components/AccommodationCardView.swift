//
//  AccommodationCardView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI
import CoreData

struct AccommodationCardView: View {
        let accommodation: Accomodation
        
        @ScaledMetric var size = CGFloat(1)
        
        var body: some View {
            
            ZStack {
                
                Rectangle()
                        .foregroundColor(.white)
                        .frame(minWidth: 200*size, minHeight: 240*size)
                        .cornerRadius(14)
                        .shadow(radius: 4)
                    
                VStack(alignment: .leading) {
                    
                    if let cardCover = accommodation.card_cover,
                        let uiImage = UIImage(data: cardCover) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 200*size, minHeight: 150*size)
                            
                    } else {
                        Image("ph1")
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 200*size, minHeight: 150*size)
                            
                    }
                        

                    Text(accommodation.wrappedTitle)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                    
                    HStack {
                        Text(accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                            .font(.system(size: 12))
                        .foregroundColor(.black)
                        Spacer()
                        Button(action: {
                        }, label: {
                            Image(systemName: accommodation.isFavourite ? "heart.fill" : "heart")
                        })
                    }
                    .frame(minWidth: 200*size)
                    .padding([.leading, .trailing], 10)
                    
                }
                .mask(Rectangle()
                    .frame(minWidth: 200, minHeight: 240)
                    .cornerRadius(14)
                       )

                .padding(.bottom, 10)
            }
        }
    }
struct AccommodationCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationCardView(accommodation: .init())
    }
}
