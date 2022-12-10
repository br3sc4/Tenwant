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
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Accomodation.title, order: .forward)])
    private var accommodations: FetchedResults<Accomodation>
    
    @FetchRequest(sortDescriptors: [])
    private var pointsOfInterest: FetchedResults<PointOfInterest>
    
    var body: some View {
        NavigationStack {
            MapViewRepresentable(region: $vm.region,
                                 accommodations: Array(accommodations),
                                 pointsOfInterest: Array(pointsOfInterest),
                                 selectedAccommodation: $vm.selectedAccommodation)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddPoISheet.toggle()
                    } label: {
                        Label("Add Point of Interest", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddPoISheet) {
                        AddPoIView()
                            .presentationDetents([.medium])
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
                AccommodationSheetView(accommodation: accommodation, userLocation: vm.userLocation)
                    .presentationDetents([.medium, .large])
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

struct AccommodationSheetView: View {
    private let accommodation: Accomodation
    private let userLocation: CLLocation
    
    init(accommodation: Accomodation, userLocation: CLLocation) {
        self.accommodation = accommodation
        self.userLocation = userLocation
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    Text("Rent price")
                        .font(.headline)
                    Text(accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                        .font(.subheadline)
                }
                
                Divider()
                
                VStack {
                    Text("Extra costs")
                        .font(.headline)
                    Text(accommodation.extra_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                        .font(.subheadline)
                }
                
                Divider()
                
                VStack {
                    Text("Distance")
                        .font(.headline)
                    Text(accommodation.distance(from: userLocation).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(.zero)))))
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(accommodation.wrappedTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
