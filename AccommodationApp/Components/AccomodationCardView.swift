//
//  AccomodationCardView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct AccomodationCardView: View {
    
    @ScaledMetric var size = CGFloat(1)
    
    var body: some View {
        
        ZStack{
            
        Rectangle()
                .foregroundColor(.white)
                .frame(minWidth: 200*size, minHeight: 240*size)
                .cornerRadius(10)
                .shadow(radius: 4)
        VStack(alignment: .leading) {
            
            Image("ph1")
                .resizable()
                .scaledToFill()
                .frame(minWidth: 200*size, minHeight: 150*size)
                .clipShape(Rectangle())
                

            Text("ADDRESS")
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            HStack {
                Text("$$$")
                    .font(.system(size: 12))
                .foregroundColor(.black)
                Spacer()
                Button(action: {
                }, label: {
                   Image(systemName: "heart")
                })
            }
            .frame(minWidth: 200*size)
            
        }
        .padding(.bottom, 5)
    }
    }
}

struct AccomodationCardView_Previews: PreviewProvider {
    static var previews: some View {
        AccomodationCardView()
    }
}
