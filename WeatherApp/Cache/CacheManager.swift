//
//  CacheManager.swift
//  Weather App
//
//  Created by mac on 13/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

class CacheManager{
    
    weak private var prefrencesData = UserDefaults.standard
    static let shared: CacheManager = {
        let instance = CacheManager()
        return instance
    }()
    
    private init() {
    }
    
    var latitude:String{
        get {
            return prefrencesData?.object(forKey: MiscellaneousKey.latitude) as? String ?? ""
        }
        set {
            prefrencesData?.set(newValue, forKey: MiscellaneousKey.latitude)
        }
    }
    
    var logitude:String{
        get {
            return prefrencesData?.object(forKey: MiscellaneousKey.longitude) as? String ?? ""
        }
        set {
            prefrencesData?.set(newValue, forKey: MiscellaneousKey.longitude)
        }
    }
    
    var CurrentCity:String{
        get {
            return prefrencesData?.object(forKey: MiscellaneousKey.CurrentCity) as! String
        }
        set {
            prefrencesData?.set(newValue, forKey: MiscellaneousKey.CurrentCity)
        }
    }
    
    var TimeZone:String{
        get {
            return prefrencesData?.object(forKey: APIKey.timeZone) as! String
        }
        set {
            prefrencesData?.set(newValue, forKey: APIKey.timeZone)
        }
    }
    
    var CurrentWeather:String{
        get {
            return prefrencesData?.object(forKey: ApiWrapingDataKey.currently) as! String
        }
        set {
            prefrencesData?.set(newValue, forKey: ApiWrapingDataKey.currently)
        }
    }
    
    var DailyForcastWeather:String{
        get {
            return prefrencesData?.object(forKey: ApiWrapingDataKey.daily) as! String
        }
        set {
            prefrencesData?.set(newValue, forKey: ApiWrapingDataKey.daily)
        }
    }
    
}
