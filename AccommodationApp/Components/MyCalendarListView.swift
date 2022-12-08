//
//  MyCalendarListView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarListView: View {
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading,spacing: 10){
                ForEach(0..<10){_ in
                    VStack(alignment: .leading){
                        Text("Day 00 Month 0000")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                            .bold()
                        if true {
                            ForEach(0..<10){_ in
                                NavigationLink(destination: ContentView(), label:
                                                {
                                    MyCalendarRowView()
                                })
                            }
                        }
                    }.padding(.bottom, 9)
                }
            }
        }
    }
}

struct MyCalendarListView_Previews: PreviewProvider {
    static var previews: some View {
        MyCalendarListView()
    }
}
