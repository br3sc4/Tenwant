//
//  MyCalendarRowView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarRowView: View {
    
    var accommodation: Accomodation
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            ZStack{
                
            
                ZStack(alignment: .topLeading){
                Rectangle()
//                    .foregroundColor(.white)
                    .foregroundColor(.gray)
//                    .cornerRadius(14)
//                    .shadow(radius: 1)
                    .frame(width: 345, height: 70)
                    .opacity(0.1)
                    .padding(.leading, -8)
//
                Rectangle()
                    .frame(width: 5, height: 70)
                    .foregroundColor(.gray)
                    
            }
//            .mask(Rectangle()
//                .frame(width: 345, height: 70)
//                .cornerRadius(14)
//                   )
                
                if let appointment = accommodation.scheduled_appointment{
                    VStack(alignment: .leading, spacing: 5){
                        
                        HStack {
                            Text(accommodation.title ?? accommodation.wrappedTitle)
                                .lineLimit(1)
                                .foregroundColor(.primary)
                                .font(.system(size: 12))
                                .bold()
                            
                            Spacer()
                            Text(appointment.formatted(date: .omitted, time: .shortened))
                                .foregroundColor(.primary)
                                .font(.system(size: 12))
                                .bold()
                            
                        }
                        Text("name of the person")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                        
                        Text(accommodation.contact ?? "")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))
                        
                    }.frame(width: 320, height: 70)
                        
                }
            }
        }
        
    }
}

struct MyCalendarRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyCalendarRowView(accommodation: .init())
    }
}
