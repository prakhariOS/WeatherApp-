//
//  JSONDownloader.swift
//  WeatherApp
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

typealias JSONData = [String: AnyObject]
typealias CompletionHandler = (JSONData?, DarkSkyAPIError?) -> Void

class JSONDownloader {
    static let shared = JSONDownloader()
    
    func jsonTaskWith(request: URLRequest, completionHandler completion: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode != 200 {
                completion(nil, .responseUnsuccessful)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                completion(json, nil)
            } catch {
                completion(nil, .jsonConversionFailure)
            }
        }
        
        return task
    }
}
