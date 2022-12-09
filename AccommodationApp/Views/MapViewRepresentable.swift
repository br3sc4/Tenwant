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
    
    var region: MKCoordinateRegion
    
    let trackingMode: MKUserTrackingMode = .follow
    
    private let accommodations: [Accommodation]
    
    init(region: MKCoordinateRegion, accommodations: [Accommodation]) {
        self.region = region
        self.accommodations = accommodations
    }

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
         
        map.setRegion(region, animated: true)
        map.centerCoordinate = region.center
        
        map.showsScale = true
        map.showsCompass = false
        map.showsUserLocation = true
        Task { @MainActor in
            map.setUserTrackingMode(trackingMode, animated: true)
        }
        
        setupUserTrackingButton(mapView: map)
        setupCompassButton(mapView: map)
        
        map.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .realistic)

        map.addAnnotations(accommodations.map(AccommodationAnnotation.init))
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator()
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? AccommodationAnnotation else { return nil }
                
            let identifier = AnnotationIentifier.accommodation
            var view: MKMarkerAnnotationView
            
            if let dequeuedView = mapView
                .dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.markerTintColor = annotation.color
                view.calloutOffset = CGPoint(x: 0, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        
        private enum AnnotationIentifier {
            static let accommodation = "accommodation"
        }
    }
    
    private func setupUserTrackingButton(mapView: MKMapView) {
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        trackingButton.backgroundColor = .tertiarySystemGroupedBackground
        trackingButton.tintColor = .systemGray
        trackingButton.layer.cornerRadius = 4
        mapView.addSubview(trackingButton)
        
        trackingButton.translatesAutoresizingMaskIntoConstraints = false
        trackingButton.trailingAnchor.constraint(equalTo: mapView.layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
        trackingButton.topAnchor.constraint(equalTo: mapView.layoutMarginsGuide.topAnchor, constant: 42).isActive = true
    }
    
    private func setupCompassButton(mapView: MKMapView) {
        let compassButton = MKCompassButton(mapView: mapView)
        mapView.addSubview(compassButton)
        
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapView.layoutMarginsGuide.trailingAnchor, constant: -14).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapView.layoutMarginsGuide.topAnchor, constant: 42*2+8).isActive = true
    }
}

struct MapViewRepresntable_Previews: PreviewProvider {
    @State static private var region = MKCoordinateRegion(center: MapLocations.naples, span: MapLocations.span)
    
    static var previews: some View {
        MapViewRepresentable(region: region, accommodations: Accommodation.accommodations)
            .ignoresSafeArea()
    }
}
