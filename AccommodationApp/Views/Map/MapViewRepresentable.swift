//
//  MapViewRepresentable.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import SwiftUI
import MapKit
import CoreData

struct MapViewRepresentable: UIViewRepresentable {
    typealias UIViewType = MKMapView
    @Environment(\.managedObjectContext) private var moc: NSManagedObjectContext
    
    @Binding private var region: MKCoordinateRegion
    
    let trackingMode: MKUserTrackingMode = .follow
    
    private let accommodations: [Accomodation]
    private let pointsOfInterest: [PointOfInterest]
    
    @Binding private var selectedAccommodation: Accomodation?
    
    private let locationManager: CLLocationManager?
    
    init(region: Binding<MKCoordinateRegion>,
         accommodations: [Accomodation],
         pointsOfInterest: [PointOfInterest],
         selectedAccommodation: Binding<Accomodation?>,
         locationManager: CLLocationManager?) {
        self._region = region
        self.accommodations = accommodations
        self.pointsOfInterest = pointsOfInterest
        self._selectedAccommodation = selectedAccommodation
        self.locationManager = locationManager
    }

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
         
        map.setRegion(region, animated: true)
        map.centerCoordinate = region.center
        
        map.showsScale = true
        
//        if let authorizationStatus = locationManager?.authorizationStatus, authorizationStatus != .denied {
            map.showsCompass = false
            setupUserTrackingButton(mapView: map)
            setupCompassButton(mapView: map)
            
            Task { @MainActor in
                map.setUserTrackingMode(trackingMode, animated: true)
            }
//        } else {
//            map.showsCompass = true
//        }
        
//        map.selectableMapFeatures = [.physicalFeatures, .pointsOfInterest, .territories]
        
        map.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .realistic)

        map.addAnnotations(accommodations.map(AccommodationAnnotation.init))
        map.addAnnotations(pointsOfInterest.map(PoIAnnotation.init))
        
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print(Date.now, uiView.annotations.count, accommodations.count + pointsOfInterest.count)
        if selectedAccommodation == nil {
            if accommodations.count + pointsOfInterest.count >= uiView.annotations.count {
                uiView.removeAnnotations(uiView.annotations)

                uiView.addAnnotations(accommodations.map(AccommodationAnnotation.init))
                uiView.addAnnotations(pointsOfInterest.map(PoIAnnotation.init))
            }
            
            guard let annotation = uiView.selectedAnnotations.first else { return }
            uiView.deselectAnnotation(annotation, animated: true)
        }
        
//        if let authorizationStatus = locationManager?.authorizationStatus, authorizationStatus != .denied {
//            uiView.showsCompass = false
//            setupUserTrackingButton(mapView: uiView)
//            setupCompassButton(mapView: uiView)
//            
//            Task { @MainActor in
//                uiView.setUserTrackingMode(trackingMode, animated: true)
//            }
//        } else {
//            uiView.showsCompass = true
//        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(region: $region, selectedAccommodation: $selectedAccommodation, moc: moc)
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        @Binding private var region: MKCoordinateRegion
        @Binding private var selectedAccommodation: Accomodation?
        private let moc: NSManagedObjectContext
        
        fileprivate init(region: Binding<MKCoordinateRegion>,
                         selectedAccommodation: Binding<Accomodation?>,
                         moc: NSManagedObjectContext) {
            self._region = region
            self._selectedAccommodation = selectedAccommodation
            self.moc = moc
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            var identifier: String
            var markerTintColor: UIColor
            var canShowCallout: Bool = false
            var rightCalloutAccessoryView: UIView = UIView()
            var view: MKMarkerAnnotationView
            
            if let annotation = annotation as? AccommodationAnnotation {
                identifier = AnnotationIentifier.accommodation
                markerTintColor = annotation.color
            } else if let annotation = annotation as? PoIAnnotation {
                identifier = AnnotationIentifier.poi
                markerTintColor = annotation.color
                canShowCallout = true
                rightCalloutAccessoryView = makeAccessoryDeleteButton()
            } else {
                return nil
            }
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                view.markerTintColor = markerTintColor
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.markerTintColor = markerTintColor
                view.canShowCallout = canShowCallout
                view.rightCalloutAccessoryView = rightCalloutAccessoryView
            }
            return view
        }
        
        func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            guard let annotation = annotation as? AccommodationAnnotation else { return }
            selectedAccommodation = annotation.accommodation
        }
        
        func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
            guard let _ = annotation as? AccommodationAnnotation else { return }
            Task { @MainActor in
                selectedAccommodation = nil
            }
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            Task { @MainActor in
                region = mapView.region
            }
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation as? PoIAnnotation else { return }
            
            moc.delete(annotation.poi)
            try? moc.save()
            
            mapView.removeAnnotation(annotation)
        }
        
        private func makeAccessoryDeleteButton() -> UIButton {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "trash"), for: .normal)
            button.tintColor = .systemRed
            button.sizeToFit()
            return button
        }
        
        private enum AnnotationIentifier {
            static let accommodation = "accommodation"
            static let poi = "point-of-interest"
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
    @State static private var region = MKCoordinateRegion(center: MapLocations.naples,
                                                          span: MapLocations.span)
    
    static var previews: some View {
        MapViewRepresentable(region: $region,
                             accommodations: Accomodation.accommodations,
                             pointsOfInterest: PointOfInterest.pois,
                             selectedAccommodation: .constant(nil),
                             locationManager: CLLocationManager())
            .ignoresSafeArea()
    }
}
