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
    
    private let accommodations = [
        AccommodationAnnotation(title: "Via Pietro Metastasio 47",
                                subtitle: "\(350.formatted(.currency(code: "EUR"))) • Distance from me",
                                latitude: 40.832340,
                                longitude: 14.199398,
                                status: .free)
    ]

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        
        let naples = CLLocationCoordinate2D(latitude: 40.839893, longitude: 14.251971)
        let region = MKCoordinateRegion(center: naples,
                                        span: MapViewRepresentable.span)
        map.setRegion(region, animated: true)
        
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        
        map.addAnnotations(accommodations)
        
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
                view.markerTintColor = annotation.markerColor
                view.calloutOffset = CGPoint(x: 0, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
        }
        
        private enum AnnotationIentifier {
            static let accommodation = "accommodation"
        }
    }
}

struct MapViewRepresntable_Previews: PreviewProvider {
    static var previews: some View {
        MapViewRepresentable()
            .ignoresSafeArea()
    }
}
