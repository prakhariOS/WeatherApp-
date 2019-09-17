//
//  CurrentWeather.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let precipitationProbability: Double
    let summary: String
    let icon: String
    let timezone: String
    let wind:Double
    let preciptitation:Double
}

extension CurrentWeather {
    init?(json: JSON,timeZone:String) {
        guard let tempValue = json[APIKey.temperature].double, let humidityValue = json[APIKey.humidity].double, let precipProbabilityValue = json[APIKey.precipProbability].double, let summaryString = json[APIKey.summary].string, let iconString = json[APIKey.icon].string, let wind  = json[APIKey.wind].double, let preciptitation  = json[APIKey.preciptitation].double  else {
            return nil
        }
        let cityWithtimeZone = MiscellaneousKey.city + CacheManager.shared.CurrentCity + MiscellaneousKey.nextline + MiscellaneousKey.timezone + timeZone
        self.temperature = tempValue
        self.humidity = humidityValue
        self.precipitationProbability = precipProbabilityValue
        self.summary = summaryString
        self.icon = iconString
        self.timezone =  cityWithtimeZone
        self.wind = wind
        self.preciptitation = preciptitation
    }
}

