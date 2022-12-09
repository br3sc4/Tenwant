//
//  MapView.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import SwiftUI

struct MapView: View {
    @StateObject private var vm: MapViewModel = MapViewModel()
    private let accommodations: [Accommodation] = Accommodation.accommodations
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            MapViewRepresentable(region: vm.region, accommodations: accommodations)
                .edgesIgnoringSafeArea(.top)
        }
        .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
            Button("Cancel", role: .cancel) {
                vm.showAlert.toggle()
            }
        } message: {
            Text(vm.alertContent.message)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
