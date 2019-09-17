//
//  CurrentWeatherViewModel.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    let timezone: String
    let wind:String
    let preciptitation:String


    
    init(from model: CurrentWeather) {
        let temiInCelcius = model.temperature.calculateTempToCelcius(tempreature: model.temperature)
        let rawValue = (temiInCelcius).rounded(toPlaces: 0)        
        self.temperature = "\(rawValue.int())ºC"
        
        let humidityValue = model.humidity.percent().int()
        self.humidity = "\(humidityValue)%"
        
        let precipValue = model.precipitationProbability.percent().int()
        self.precipitationProbability = "\(precipValue)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
        self.timezone = model.timezone
        self.wind = "\(model.wind)"
        self.preciptitation = "\(model.preciptitation)%"
    }
}


