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
        for accommodation in accommodations{
            let scheduled_appointment = Calendar.current.startOfDay(for: accommodation.scheduled_appointment ?? Date.now)
            
            if dictionary.contains(where: { key, value in
                
                key.formatted(date: .long, time:.omitted) == accommodation.scheduled_appointment?.formatted(date: .long, time:.omitted)
                
            }){
                dictionary[scheduled_appointment]!.append(accommodation)
            }else{
                dictionary[scheduled_appointment] = [accommodation]
            }
        }
        return dictionary
    }
    
    var body: some View {
        
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false){
                ForEach(Array(accommodationByDate.keys).sorted(by: <), id: \.self){ date in
                    
                    VStack(alignment: .leading){
                        //giving a fixed id to today so that scrollviewreader can access to the anchor point
                        if date.formatted(date: .long, time:.omitted) == Date.now.formatted(date: .long, time:.omitted)
                        {
                            Text(date.formatted(date: .long, time:.omitted))
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .bold()
                                .id(2)
                        }
                        
                        else {
                            Text(date.formatted(date: .long, time:.omitted))
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .bold()
                        }
                        
                        ForEach(accommodationByDate[date] ?? [], id: \.id){ accommodation in
                            NavigationLink {
                                AccommodationDetailsView(accommodation: accommodation)
                            } label: {
                                MyCalendarRowView(accommodation: accommodation)
                            }
                        }
                    }
                    
                }.padding(.bottom, 9)
            }
            
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    Button(action: {
                        withAnimation {
                            reader.scrollTo(2, anchor: .top)
                        }
                    }, label:
                            {
                        Text("Today")
                    })
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

