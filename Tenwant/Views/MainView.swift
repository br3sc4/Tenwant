//
//  MainView.swift
//  AccommodationApp
//
//  Created by Antonella Giugliano on 07/12/22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass: UserInterfaceSizeClass?
    @State private var selectedPage: SelectedPage? = .accommodations
    
    var body: some View {
        if sizeClass == .compact {
            tabView
        } else {
            navigationView
        }
    }
    
    private var tabView: some View {
        TabView {
            MyAccommodationsView()
                .tabItem {
                    Label("My Accommodations", systemImage: "square.grid.2x2")
                }
            
            MyCalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
    
    private var navigationView: some View {
        NavigationSplitView {
            List(selection: $selectedPage) {
                NavigationLink {
                    MyAccommodationsView()
                } label: {
                    Label("My Accommodations", systemImage: "square.grid.2x2")
                }
                
                NavigationLink {
                    MyCalendarView()
                } label: {
                    Label("Calendar", systemImage: "calendar")
                }

                NavigationLink {
                    MapView()
                } label: {
                    Label("Map", systemImage: "map")
                }
            }
        } detail: {
            MyAccommodationsView()
        }
    }
    
    private enum SelectedPage: Int, Hashable {
        case accommodations, appointments, map
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
