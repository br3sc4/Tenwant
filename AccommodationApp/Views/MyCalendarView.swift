//
//  MyCalendarView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarView: View {
    @State var showList = true
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing){
                if showList{
                    MyCalendarListView()
                }
                else{
                    MyCalendarWeeklyView()
                }

            }
            .navigationTitle("Calendar")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button(action: {
                        showList.toggle()
                    }, label:
                            {
                        Image(systemName: (showList ? "calendar" : "list.bullet"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    })
                }
                ToolbarItem(placement: .primaryAction){
                    Button(action: {
                    }, label:
                            {
                        Text("Today")
                    })
                }
            }
        }
    }
}

struct MyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarView()
    }
}
