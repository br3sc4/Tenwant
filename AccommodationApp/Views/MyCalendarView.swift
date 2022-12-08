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
                    MyCalendarListView()
                }
                Button(action: {
                    showList.toggle()
                }, label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.teal)
                            .frame(width: 60)
                            .shadow(radius: 4)
                        Image(systemName: (showList ? "list.bullet" : "calendar"))
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            
                    }
                }).padding(.bottom, 15)

            }
            .navigationTitle("Calendar")
            .toolbar{
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
