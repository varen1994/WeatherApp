//
//  ViewController.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,MKMapViewDelegate {

    private let reUseIdentifier = "PinView"
    @IBOutlet var mapView:MKMapView!
    var observer:NSKeyValueObservation?
    var annotation:MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocationManager()
        self.mapView.delegate = self
    }
    
    func startLocationManager() {
        LocationManager.shared.startLocatingCurrentLocation()
        observer = LocationManager.shared.observe(\.currentLocation, options: .new, changeHandler: { (manager, change) in
            self.updateToNewLocation(location:LocationManager.shared.currentLocation)
        })
    }
    
    func updateToNewLocation(location:CLLocation?) {
        guard let locationNew = location else {
            return
        }
        if let annotation = self.annotation {
            annotation.coordinate = locationNew.coordinate
        } else {
            self.annotation =  MKPointAnnotation()
            self.annotation?.title = "Current Location"
            self.annotation?.coordinate = locationNew.coordinate
            self.mapView.addAnnotation(self.annotation!)
        }
        self.centerMapOnLocation(location: locationNew)
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let regionRadius: CLLocationDistance = 200
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:self.reUseIdentifier)
        annotationView.isEnabled = true
        annotationView.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "WeatherController") as? WeatherController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

