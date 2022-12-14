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
                    .foregroundColor(.secondary)
                    .cornerRadius(4.5)
                    .shadow(radius: 1)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 45)
                    .opacity(0.2)
                
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
                            }
                            
                            if let contactName = accommodation.contact_name{
                                Text(contactName)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                    .font(.subheadline)
                            }
                            
                            if let contactPhone = accommodation.contact_phone{
                                Text(contactPhone)
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                    .font(.subheadline)
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
