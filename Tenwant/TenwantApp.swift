//
//  TenwantApp.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 07/12/22.
//

import SwiftUI

@main
struct TenwantApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
