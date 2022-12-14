//
//  ContentView.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 07/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
            
            .navigationTitle("llllll")
            .toolbarBackground(Color.teal, for: .navigationBar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
