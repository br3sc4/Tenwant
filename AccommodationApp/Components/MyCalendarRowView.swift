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
        
        if let appointment = accommodation.scheduled_appointment{
            
            ZStack(alignment: .center){
                
                Rectangle()
//                                    .foregroundColor(.white)
                    .foregroundColor(.secondary)
                    .cornerRadius(4.5)
                    .shadow(radius: 1)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 45)
                    .opacity(0.2)
//                    .padding(.leading, -8)
                
                Rectangle()
//                                    .foregroundColor(.white)
                    .foregroundColor(.secondary)
//                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .frame(width: 2)
                    .frame(minHeight: 9)
                    .opacity(0.3)
                        .padding(.leading, -100)
                        .padding([.bottom, .top], 6)

                
                    HStack(alignment: .center, spacing: 25) {
                       
                            Text(appointment.formatted(date: .omitted, time: .shortened))
                                .foregroundColor(.primary)
                                .font(.system(size: 12))
                                .bold()
                                .font(.subheadline)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            if let title = accommodation.title{
                                Text(title)
                                    .lineLimit(1)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                    .font(.subheadline)
//                                    .padding([.bottom, .top], 1)
                            }
                            if let contactName = accommodation.contact_name{
                                Text(contactName)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                    .font(.subheadline)
//                                    .padding([.bottom, .top], 1)
                            }
                            if let contactPhone = accommodation.contact_phone{
                                Text(contactPhone)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                    .font(.subheadline)
//                                    .padding([.bottom, .top], 1)
                            }
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
               
            }
        }
    }
    
}


struct MyCalendarRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        MyCalendarRowView(accommodation: .init())
    }
}
