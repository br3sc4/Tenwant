//
//  MyCalendarListView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarListView: View {
    
    let accommodations: FetchedResults<Accomodation>
    
    var body: some View {
        
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false){
                ZStack {
                    VStack(alignment: .leading,spacing: 10){
                        
                        ForEach(accommodations, id: \.self.id){ accommodation in
                            VStack(alignment: .leading){
                                Text(accommodation.scheduled_appointment?.formatted(date: .long, time:.omitted) ?? Date.now.formatted())
                                    .foregroundColor(.primary)
                                    .font(.system(size: 14))
                                    .bold()
                                
                                
                                if accommodation.scheduled_appointment?.formatted(date: .long, time:.omitted) == Date.now.formatted(date: .long, time:.omitted) {
                                    NavigationLink(destination: AccommodationDetailsView(accommodation: accommodation), label:
                                                    {
                                        MyCalendarRowView()
                                            .id(2)
                                    })
                                }
                                else{
                                    NavigationLink(destination: AccommodationDetailsView(accommodation: accommodation), label:
                                                    {
                                        MyCalendarRowView()
                                        
                                    })
                                }
                                
                                
                            }.padding(.bottom, 9)
                            Spacer().id(accommodation.id)
                        }
                    }
                }
            }.toolbar{
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

