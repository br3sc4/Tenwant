//
//  MyCalendarRowView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarRowView: View {
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack{
                
            
            HStack{
                Rectangle()
                    .frame(width: 5, height: 50)
                    .foregroundColor(.gray)
                    
                Rectangle()
                    .frame(width: 345, height: 50)
                    .foregroundColor(.gray)
                    .opacity(0.2)
                    .padding(.leading, -8)
            }
                VStack(alignment: .leading, spacing: 5){
                    
                    HStack {
                        Text("Day 00 Month 0000")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                        .bold()
                        
                        Spacer()
                        Text("00:00")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                        
                    }
                    Text("Description")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        
                }.frame(width: 320, height: 50)
            }
        }
    }
}

struct MyCalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarRowView()
    }
}
