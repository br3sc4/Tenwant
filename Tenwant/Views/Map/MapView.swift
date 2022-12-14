//
//  MapView.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import SwiftUI
import CoreData
import CoreLocation

struct MapView: View {
    @StateObject private var vm: MapViewModel = MapViewModel()
    @State private var showAddPoISheet: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var accommodations: FetchedResults<Accomodation>
    
    @FetchRequest(sortDescriptors: [])
    private var pointsOfInterest: FetchedResults<PointOfInterest>
    
    @Environment(\.horizontalSizeClass) private var sizeClass: UserInterfaceSizeClass?
    
    var body: some View {
        NavigationStack {
            Group {
                if sizeClass == .compact {
                    MapViewRepresentable(region: $vm.region,
                                         accommodations: Array(accommodations),
                                         pointsOfInterest: Array(pointsOfInterest),
                                         selectedAccommodation: $vm.selectedAccommodation,
                                         locationManager: vm.locationManager)
                } else {
                    MapViewRepresentable(region: $vm.region,
                                         accommodations: Array(accommodations),
                                         pointsOfInterest: Array(pointsOfInterest),
                                         selectedAccommodation: $vm.selectedAccommodation,
                                         locationManager: vm.locationManager)
                    .edgesIgnoringSafeArea([.bottom])
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddPoISheet.toggle()
                    } label: {
                        Label("Add Point of Interest", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddPoISheet) {
                        AddPoIView()
                    }
                }
            }
            .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showAlert.toggle()
                }
            } message: {
                Text(vm.alertContent.message)
            }
            .sheet(item: $vm.selectedAccommodation) { accommodation in
                AccommodationSheetView(accommodation: accommodation,
                                       userLocation: vm.userLocation)
                    .presentationDetents([.medium, .large])
                    .interactiveDismissDisabled(true)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewDevice("iPhone 14 Pro")
        
        MapView()
            .previewDevice("iPad Air (5th generation)")
    }
}
