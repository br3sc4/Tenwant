//
//  MapViewModel.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import MapKit

enum MapLocations {
    static let naples = CLLocationCoordinate2D(latitude: 40.839893, longitude: 14.251971)
    static let ferrara = CLLocationCoordinate2D(latitude: 44.835914, longitude: 11.619324)
    static let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

final class MapViewModel: NSObject, ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(center: MapLocations.ferrara,
                                                                   span: MapLocations.span)
    
    @Published var selectedAccommodation: Accomodation?
    
    var userLocation: CLLocation {
        locationManager?.location ?? CLLocation()
    }
    
    var mapType: MKMapConfiguration = MKStandardMapConfiguration()
    
    @Published var showAlert: Bool = false
    private(set) var alertContent: AlertContent = AlertContent()
    
    private(set) var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        
        Task {
            if CLLocationManager.locationServicesEnabled() {
                Task { @MainActor in
                    locationManager = CLLocationManager()
                    setupLocationManager()
                }
            } else {
                showAlert(title: "Location services disabled", message: "Go to setting and enable them")
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        alertContent = AlertContent(title: title, message: message)
        showAlert.toggle()
    }
    
    private func setupLocationManager() {
        locationManager?.delegate = self
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showAlert(title: "Location authorization restricted",
                      message: "Your location is restricted likely due to parental controls.")
        case .denied:
            showAlert(title: "Location authorization denied",
                      message: "You denied the this app location permission. Go into settings to change it.")
        case .authorizedWhenInUse:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { print($0.coordinate) }
        guard let location = locations.first else { return }
        region.center = location.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ - \(error)")
    }
}
