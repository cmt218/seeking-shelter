//
//  MapViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/17/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let mapView = MKMapView(frame: .zero)
    private var locations: [ShelterLocation] = []
    let locationManager = CLLocationManager()
    
    private enum Constants {
        
    }
    
    init() {
        locations = WebService().getStaticData()?.locations ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
        configureSubviews()
        configureLayout()
        title = "Map"
        let initialLocation = CLLocation(latitude: 42.3521084, longitude: -71.05913125954545)
        centerMapOnLocation(location: initialLocation)
        addPoints()
    }
    
}

// MARK : Private

private extension MapViewController {
    func configureSubviews() {
        view.backgroundColor = .gray
        view.addSubview(mapView)
    }
    
    func configureLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPoints() {
        mapView.addAnnotations(locations)
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
