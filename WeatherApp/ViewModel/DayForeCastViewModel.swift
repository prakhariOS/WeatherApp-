//
//  DayForeCastViewModel.swift
//  Weather App
//
//  Created by mac on 14/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

import UIKit

struct DayForcastViewModel {
    
    let temperatureMax: Double
    let temperatureMin: Double
    let humidity: Int
    let date: String
    let icon: UIImage
    
    
    init(from model: DayForcastWeather) {
        let temiInCelcius = model.temperatureMax.calculateTempToCelcius(tempreature: model.temperatureMax)
        let rawValue = (temiInCelcius).rounded(toPlaces: 0)
        self.temperatureMax = rawValue
        let temiMinCelcius = model.temperatureMin.calculateTempToCelcius(tempreature: model.temperatureMin)
        let rawValueMin = (temiMinCelcius).rounded(toPlaces: 0)
        self.temperatureMin = rawValueMin
        let rawDate = Date(timeIntervalSince1970: model.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = MiscellaneousKey.dataFormat
        let strDate = dateFormatter.string(from: rawDate)
        let weekAndDate = "\(rawDate.dayOfTheWeek())" + " " + strDate
        self.date = weekAndDate
        let weatherIcon = WeatherIcon(iconString:model.icon)
        self.icon = weatherIcon.image
        self.humidity = model.humidity.percent().int()
        
    }
}
