//
//  PhotosScrollView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 09/12/22.
//

import SwiftUI

struct PhotosScrollView: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 5){
                ForEach(0..<30) { idx in
                        Image("ph1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 320, height: 225)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .circular))
                            .shadow(radius: 2)
                    }
                
                .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 0))
            }
            
        }
        
    }
}

struct PhotosScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosScrollView()
    }
}
