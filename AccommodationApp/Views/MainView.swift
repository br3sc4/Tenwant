//
//  MainView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MyAccomodations()
                .tabItem {
                    Label("Gallery", systemImage: "square.grid.2x2")
                }
            ContentView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            ContentView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
