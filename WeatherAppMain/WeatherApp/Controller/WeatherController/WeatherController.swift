//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var tempMaxMin: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var data:WeatherReponse? = nil {
        didSet {
            self.setDataInTheLabels()
        }
    }
    
    lazy var activityIndicator:UIActivityIndicatorView = {
       let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tintColor = UIColor.blue
        activityIndicator.style = .large
        activityIndicator.center = self.view.center
        activityIndicator.stopAnimating()
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDataInTheLabels()
        self.getDataFromApi()
    }
    
    
    func setDataInTheLabels() {
        if let model = self.data {
            let arrayPlace = [model.name ?? "" ,model.sys?.country ?? ""]
            self.placeLabel.text = arrayPlace.joined(separator: " ")
            self.wind.text = "Wind Speed =" + "\(model.wind?.speed ?? 0.0)" + "\n" + "Wind Dir =" + "\(model.wind?.deg ?? 0)"
            self.temp.text = "Temp =" + "\(model.main?.temp ?? 0.0) F"
            self.tempMaxMin.text = "Temp Min =" + "\(model.main?.temp_min ?? 0.0) F" + "\n" + "Temp Max ="  + "\(model.main?.temp_max ?? 0.0) F"
            self.descriptionLabel.text = model.weather?.first?.description ?? ""
        } else {
            self.wind.text = nil
            self.temp.text = nil
            self.tempMaxMin.text = nil
            self.descriptionLabel.text = nil
            self.placeLabel.text = nil
        }
    }
    
    func getDataFromApi() {
        self.activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        guard let location = LocationManager.shared.currentLocation else { return }
        ApiManager.shared.getWeatherFromApi(lat: Float(location.coordinate.latitude), long: Float(location.coordinate.longitude)) { (response, error) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            DispatchQueue.main.async {
                if let error = error {
                    self.getDataFromUserDefaults()
                    self.showAlert(error: error)
                } else {
                    self.data = response
                }
            }
        }
    }
    
    func getDataFromUserDefaults() {
        let decoder = JSONDecoder()
        if let data = DataManager.shared.getDict() {
            do {
                self.data = try decoder.decode(WeatherReponse.self, from: data)
            } catch {
                
            }
        }
    }
    
    func showAlert(error:String) {
        let alertController = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        let actionReload = UIAlertAction(title: "Reload", style: .default) { (action) in
            self.getDataFromApi()
        }
        let actionOk = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(actionOk)
         alertController.addAction(actionReload)
        self.present(alertController, animated: true, completion: nil)
    }

}
