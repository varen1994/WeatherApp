//
//  DataManager.swift
//  WeatherApp
//
//  Created by Varender Singh on 05/09/20.
//  Copyright © 2020 Varender. All rights reserved.
//

import UIKit

class DataManager: NSObject {

    private let saveDictKet = "SaveDict"
    static let shared = DataManager()
    
    private override init() {
        
    }
    
    func saveDict(data:Data) {
        UserDefaults.standard.set(data, forKey: self.saveDictKet)
        UserDefaults.standard.synchronize()
    }
    
    func getDict() -> Data? {
        if let data = UserDefaults.standard.value(forKey: self.saveDictKet) as? Data {
            return data
        }
        return nil
    }
    
}
