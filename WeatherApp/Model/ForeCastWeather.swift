//
//  ForeCastWeather.swift
//  Weather App
//
//  Created by mac on 14/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation


struct DayForcastWeather {
    let temperatureMax: Double
    let humidity: Double
    let temperatureMin: Double
    let icon: String
    let date: Double
}

extension DayForcastWeather {
    init?(json: JSON) {
        guard let temperatureMax = json[APIKey.temperatureMax].double, let humidity = json[APIKey.humidity].double, let iconString = json[APIKey.icon].string, let temperatureMin  = json[APIKey.temperatureMin].double, let date = json[APIKey.time].double  else {
            return nil
        }
        self.temperatureMax = temperatureMax
        self.humidity = humidity
        self.temperatureMin = temperatureMin
        self.icon = iconString
        self.date =  date
    }
}
