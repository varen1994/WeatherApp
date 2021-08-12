//
//  WeatherReponse.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit

class WeatherReponse: Codable {
    var coord:Coordinates?
    var weather:[Weather]?
    var wind:Wind?
    var name:String?
    var sys:Sys?
    var main:Main?

}

class Main:Codable {
    var temp:Float?
    var pressure:Float?
    var humidity:Float?
    var temp_min:Float?
    var temp_max:Float?
    var sea_level:Float?
    var grnd_level:Float?
}

class  Coordinates: Codable {
    var lon:Float?
    var lat:Float?
}


class Sys:Codable {
    var country:String?
}

class Weather:Codable {
    var description:String?
}

class Wind:Codable {
    var speed:Float?
    var deg:Int?
}

