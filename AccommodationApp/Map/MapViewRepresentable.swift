//
//  MapViewRepresentable.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    static let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        
        let naples = CLLocationCoordinate2D(latitude: 40.839893, longitude: 14.251971)
        let region = MKCoordinateRegion(center: naples,
                                        span: MapViewRepresentable.span)
        map.setRegion(region, animated: true)
        
        
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

struct MapViewRepresntable_Previews: PreviewProvider {
    static var previews: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}
