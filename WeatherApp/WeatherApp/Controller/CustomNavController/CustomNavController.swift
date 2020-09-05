//
//  CustomNavController.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit
import CoreLocation

class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       checkIfLocationIsAuthorizedOrNot()
    }
    
    func checkIfLocationIsAuthorizedOrNot() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.showMapViewController()
        } else {
            showAccessLocationScreen()
        }
    }
    
    func showMapViewController() {
        guard let mapView = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        self.setViewControllers([mapView], animated: true)
    }
    
    func showAccessLocationScreen() {
        guard let locationView = self.storyboard?.instantiateViewController(identifier: "AccessLocationViewController") as? AccessLocationViewController else { return }
        self.setViewControllers([locationView], animated: true)
    }
    
}
