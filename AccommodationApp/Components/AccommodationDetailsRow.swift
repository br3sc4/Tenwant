//
//  AccommodationDetailsRow.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI

struct AccommodationDetailsRow: View {
    
    let key: String
    let value: String
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text(key)
                .font(.system(size: 13))
                .foregroundColor(.secondary)
                .bold()
                .padding(.all, 0)
            Text(value)
                .foregroundColor(.primary)
                .font(.system(size: 13))
                .padding(.all, 0)
            Rectangle()
                .frame(width: 345, height: 1)
                .padding(.all, -4)
                .foregroundColor(.gray)
                .opacity(0.15)
                
        }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
    }
}

struct AccommodationDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        AccommodationDetailsRow(key: "ciao", value: "hello")
    }
}
