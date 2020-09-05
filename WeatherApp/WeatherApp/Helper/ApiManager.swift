//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit
import Alamofire

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    typealias CompletionHandler = (WeatherReponse?,String?)->Void
    
    private override init() {
        
    }
    
    
    func getWeatherFromApi(lat:Float,long:Float,_ completionHandler:@escaping CompletionHandler) {
        if NetworkReachabilityManager()?.isReachable == false {
            completionHandler(nil,Constant.AlertString.internetNotConnected)
            return 
        }
        guard let url = URL(string: Constant.baseURL) else {
            completionHandler(nil,Constant.AlertString.undefinedURL)
            return
        }
        let parameter = [Constant.ApiKeys.lat:lat,Constant.ApiKeys.lng:long,Constant.ApiKeys.appid:Constant.apiKey] as [String : Any]
        
        Alamofire.request(url, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: nil).responseJSON { (response) in
            if let error = response.error?.localizedDescription {
                completionHandler(nil,error)
            } else if let data = response.data  {
                do {
                    let decoder = JSONDecoder.init()
                    DataManager.shared.saveDict(data: data)
                    print(try JSONSerialization.jsonObject(with: data, options: .mutableLeaves))
                    let weatherData = try decoder.decode(WeatherReponse.self, from: data)
                    completionHandler(weatherData,nil)
                } catch {
                   completionHandler(nil,Constant.AlertString.errorOccured)
                }
            } else {
                completionHandler(nil,Constant.AlertString.errorOccured)
            }
        }
    }

}
