//
//  Constants.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import Foundation

struct Constant {
    
    static let apiKey = "f995e2bd6348b4f6433e136614c75142"
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    struct ApiKeys {
       static let lat = "lat"
       static let lng = "lon"
       static let appid = "appid"
    }
    
    struct AlertString {
        static let operationCantCancel = "Operation cannot be cancelled."
        static let undefinedURL = "Undefined url please try again later"
        static let errorOccured = "Some error occured please try again later"
        static let internetNotConnected = "Internet is not connected."
        static let internetConnected = "Internet is connected."
    }
}
