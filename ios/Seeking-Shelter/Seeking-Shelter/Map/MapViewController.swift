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
    private let webService = WebService.shared
    let locationManager = CLLocationManager()
    
    private enum Constants {
        static let reuseIdentifier = "MKMapViewDefaultAnnotationViewReuseIdentifier"
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        webService.getLocations { [weak self] shelterLocationList in
            guard let self = self else { return }
            self.locations = shelterLocationList.locations
            self.addPoints()
        }
        getCurrentLocation()
        configureSubviews()
        configureLayout()
        centerMapOnLocation(location: locationManager.location)
        title = "Map"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(goBack))
    }
    
}

// MARK : Private

private extension MapViewController {
    func configureSubviews() {
        mapView.delegate = self
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
    
    func centerMapOnLocation(location: CLLocation?) {
        let location = location ?? CLLocation(latitude: 42.3521084, longitude: -71.05913125954545) // Boston
        //let location = CLLocation(latitude: 42.3521084, longitude: -71.05913125954545)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPoints() {
        mapView.addAnnotations(locations)
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func goBack() {
        dismiss(animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getCurrentLocation()
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let tag = view.annotation as? ShelterLocation else {
            print("Could not convert tag to location")
            return
        }
        let locationDetailPageViewController = LocationDetailPageViewController(with: tag)
        //let navController = UINavigationController(rootViewController: locationDetailPageViewController)
        //present(navController, animated: true)
        navigationController?.pushViewController(locationDetailPageViewController, animated: true)
    }
}
