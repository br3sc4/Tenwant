//
//  MyCalendarView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarView: View {
//    @State var showList = true
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Accomodation.scheduled_appointment, ascending: true)],
        animation: .default)
    private var accommodations: FetchedResults<Accomodation>

    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
//                if showList{
                    MyCalendarListView(accommodations: accommodations)
//                }
//                else{
//                    MyCalendarWeeklyView()
//                }

            }
            .navigationTitle("Calendar")
//            .toolbar{
//                ToolbarItem(placement: .cancellationAction){
//                    Button(action: {
//                        showList.toggle()
//                    }, label:
//                            {
//                        Image(systemName: (showList ? "calendar" : "list.bullet"))
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                    })
//                }
//            }
        }
    }
}

struct MyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarView()
    }
}
