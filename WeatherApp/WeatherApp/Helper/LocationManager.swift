//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit
import CoreLocation

@objc class LocationManager: NSObject, CLLocationManagerDelegate {
 
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    @objc dynamic var currentLocation:CLLocation?
    
    private override init() {
        
    }
    
    func requestAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func startLocatingCurrentLocation() {
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation()
        self.currentLocation = locationManager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    
}
