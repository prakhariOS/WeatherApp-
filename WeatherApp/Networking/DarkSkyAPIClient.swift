//
//  DarkSkyAPIClient.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

typealias CurrentWeatherCompletionHandler = (CurrentWeather?, [DayForcastWeather]?,DarkSkyAPIError?) -> Void

class DarkSkyAPIClient {
    lazy var baseURL: URL = {
        return URL(string: "\(DarkSkyAPIKey.baseURL)\(DarkSkyAPIKey.apiKey)/")!
    }()
    
    static let shared = DarkSkyAPIClient()
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil, nil,.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        let task = JSONDownloader.shared.jsonTaskWith(request: request) { json, error in
            DispatchQueue.main.async {
                guard let json = json,error == nil else {
                    completion(nil, nil,error)
                    return
                }
                var jsonFinal = JSON(json)
                
                let timeZoneSend = jsonFinal[APIKey.timeZone].string ?? ""
                CacheManager.shared.TimeZone = timeZoneSend
                
                guard  let currentWeather = CurrentWeather(json: jsonFinal[ApiWrapingDataKey.currently],timeZone:timeZoneSend) else {
                    completion(nil, nil,.jsonParsingFailure)
                    return
                }
                CacheManager.shared.CurrentWeather = jsonFinal[ApiWrapingDataKey.currently].rawString() ?? ""
                
                
                var arrDayWeather = [DayForcastWeather]()
                if let list = jsonFinal[ApiWrapingDataKey.daily][ApiWrapingDataKey.data].array {
                    list.forEach({ dataList in
                        let forecast = DayForcastWeather(json: dataList)
                        arrDayWeather.append(forecast!)
                    })
                }
                CacheManager.shared.DailyForcastWeather = jsonFinal[ApiWrapingDataKey.daily].rawString() ?? ""
                
                
                completion(currentWeather,arrDayWeather,nil)
            }
        }
        
        task.resume()
    }
}
