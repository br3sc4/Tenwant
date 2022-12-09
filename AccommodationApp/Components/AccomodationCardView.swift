//
//  AccomodationCardView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI
import CoreData

struct AccomodationCardView: View {
    
    let accommodation: Accomodation
    @ScaledMetric var size = CGFloat(1)
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                    .foregroundColor(.white)
                    .frame(minWidth: 200*size, minHeight: 240*size)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                
            VStack(alignment: .leading) {
                
                if let cardCover = accommodation.card_cover,
                    let uiImage = UIImage(data: cardCover) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 200*size, minHeight: 150*size)
                        .clipShape(Rectangle())
                } else {
                    Image("ph1")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 200*size, minHeight: 150*size)
                        .clipShape(Rectangle())
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
                       Image(systemName: "heart")
                    })
                }
                .frame(minWidth: 200*size)
                .padding([.leading, .trailing], 10)
                
            }
            .padding(.bottom, 10)
        }
    }
}

struct AccomodationCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccomodationCardView(accommodation: .init())
    }
}
