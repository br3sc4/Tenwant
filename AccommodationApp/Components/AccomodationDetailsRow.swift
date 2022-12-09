//
//  AccomodationDetailsRow.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI

struct AccomodationDetailsRow: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Key")
                .foregroundColor(.secondary)
                .bold()
                
            Text("Value")
                .foregroundColor(.primary)
            Rectangle()
                .frame(width: 345, height: 1.5)
                .foregroundColor(.gray)
                .opacity(0.15)
                
            
        }.padding(.bottom, 5)
    }
}

struct AccomodationDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        AccomodationDetailsRow()
    }
}
