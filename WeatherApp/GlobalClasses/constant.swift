//
//  constant.swift
//  Weather App
//
//  Created by mac on 08/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

struct CellIdentifiers {
    static let homeWeatherCellIdentifier  = "homeWeatherHeaderCell"
    static let weatherListCellIdentifier  = "weatherListCell"
}

struct NibFile {
    static let homeWeatherCell = "HomeWeatherHeaderCell"
    static let weatherListCell = "WeatherListCell"
}

struct SequeIdentifier {
    static let homeWeatherVC   = "HomeWeather"
}

struct TableHeight {
    static let tableHeader  = 220
    static let tableList    = 130
    
}

struct MiscellaneousKey {
    static let dataFormat = "yyyy-MM-dd"
    static let city = "City:- "
    static let timezone = "Timezone:- "
    static let nextline = "\n"
    static let max = "Max: "
    static let min = "Min: "
    static let celcius = "ºC "
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let CurrentCity = "CurrentCity"
}

struct APIKey {
    static let temperature = "temperature"
    static let humidity = "humidity"
    static let precipProbability = "precipProbability"
    static let summary = "summary"
    static let icon = "icon"
    static let timezone = "timezone"
    static let wind = "windSpeed"
    static let preciptitation = "precipProbability"
    static let temperatureMax = "temperatureMax"
    static let temperatureMin = "temperatureMin"
    static let time = "time"
    static  let timeZone = "timezone"
    
}
struct ApiWrapingDataKey {
    static let  currently = "currently"
    static let  daily = "daily"
    static let  data = "data"
    
}

//MARK:- statis messages
struct staticMessages {
    static let  title = "Weather App"
    static let  locationSetting = "Weather App needs access to your location. Turn on Location Services in your device settings."
    static let  setting = "Setting"
    static let  cancel = "Cancel"
    static let  ok = "Ok"
    static let  error = "Sorry, an error occurred!"
    static let  noConnection = "Sorry, No Connection Found,Please connect with internet"
    static let  noConectionFound = "No Connection"
    
}
