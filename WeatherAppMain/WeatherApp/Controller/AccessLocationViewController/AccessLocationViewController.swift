//
//  AccessLocationViewController.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit
import CoreLocation

class AccessLocationViewController: UIViewController {

    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
                self?.timer?.invalidate()
                self?.pushToNextVC()
            }
        })
    }
    
    func pushToNextVC() {
        guard let mapView = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else { return }
        self.navigationController?.setViewControllers([mapView], animated: true)
    }
    
    @IBAction func allowLocationButtonClicke(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            LocationManager.shared.requestAuthorization()
        } else {
           alertLocationPopUp()
        }
    }
    
    func alertLocationPopUp() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                                 //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
         })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}
