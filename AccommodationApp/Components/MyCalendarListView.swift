//
//  MyCalendarListView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 08/12/22.
//

import SwiftUI

struct MyCalendarListView: View {
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.vertical, showsIndicators: false){
                ZStack {
                    VStack(alignment: .leading,spacing: 10){
                    ForEach(0..<10){ x in
                        VStack(alignment: .leading){
                            Text("Day 00 Month 0000")
                                .foregroundColor(.primary)
                                .font(.system(size: 14))
                                .bold()
                            if true {
                                ForEach(0..<10){ y in
                                    NavigationLink(destination: ContentView(), label:
                                                    {
                                        MyCalendarRowView()
                                    })
                                }
                            }
                        }.padding(.bottom, 9)
                        Spacer().id(x)
                    }
                    }
                }
            }
            Button("Go to index 2, element 3") {
                withAnimation {
                    reader.scrollTo(2)
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
