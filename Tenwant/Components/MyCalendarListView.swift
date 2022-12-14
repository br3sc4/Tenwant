//
//  MyCalendarListView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarListView: View {
    
    let accommodations: FetchedResults<Accomodation>
    var accommodationByDate: [Date: [Accomodation]] {
        var dictionary: [Date: [Accomodation]] = [:]
        for accommodation in accommodations {
            if let appointmentDate = accommodation.scheduled_appointment {
                let scheduledAppointment = Calendar.current.startOfDay(for: appointmentDate)
                
                if dictionary.contains(where: { key, value in
                    key.formatted(date: .long, time:.omitted) == appointmentDate.formatted(date: .long, time:.omitted)
                }) {
                    dictionary[scheduledAppointment]!.append(accommodation)
                } else {
                    dictionary[scheduledAppointment] = [accommodation]
                }
            }
        }
        
        return dictionary
    }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false){
                ForEach(Array(accommodationByDate.keys).sorted(by: <), id: \.self){ date in
                    VStack(alignment: .leading) {
                        // giving a fixed id to today so that scrollviewreader can access to the anchor point
                        if date.formatted(date: .long, time:.omitted) == Date.now.formatted(date: .long, time:.omitted){
                            Text(date.formatted(date: .long, time:.omitted))
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .bold()
                                .font(.headline)
                                .id(1)
                        } else {
                            Text(date.formatted(date: .long, time:.omitted))
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .bold()
                                .font(.headline)
                        }
                        
                        if let array = accommodationByDate[date] {
                            ForEach(array, id: \.id){ accommodation in
                                NavigationLink {
                                    AccommodationDetailsView(accommodation: accommodation)
                                } label: {
                                    ZStack(alignment: .trailing) {
                                        MyCalendarRowView(accommodation: accommodation)
                                            Image(systemName: "chevron.right")
                                                .padding(.trailing)
                                    }
                                    .padding([.bottom], 2)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                }
            }
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button("Today") {
                        withAnimation {
                            reader.scrollTo(1, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct MyCalendarListView_Previews: PreviewProvider {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.title, ascending: true)],
        animation: .default)
    static private var accommodations: FetchedResults<Accomodation>
    
    static var previews: some View {
        MyCalendarListView(accommodations: accommodations)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

