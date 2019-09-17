//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by mac on 17/09/19.
//  Copyright © 2019 Weather App. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    private let client = DarkSkyAPIClient()
    
    //test case to convert a temprature to celcius
    func testCalculateTempToCelcius() {
        let value = 86.00
        let concevertValue = value.calculateTempToCelcius(tempreature: value)
        XCTAssertEqual(concevertValue, 30)
    }
    //test case to convert a timestamp to days
    func testDayOfWeek(){
        let rawDate = Date(timeIntervalSince1970: 1567926000)
        let day = rawDate.dayOfTheWeek()
        XCTAssertEqual(day, "Sunday")
    }
    
    //test case for rounded the value
    func testRounded() {
        let value = 32.15
        let roundedValue = value.rounded(toPlaces: 0)
        XCTAssertEqual(roundedValue, 32)
    }
    
    //test case to convert a value to percentage
    func testPercent(){
        let value = 0.76
        let percent = value.percent()
        XCTAssertEqual(percent, 76)
    }
    
    // convert into integer
    func testConvertInt(){
        let value = 1.76
        let int = value.int()
        XCTAssertEqual(int, 1)
    }
    
    //  test case for API
    func testAPIMethod() {
        guard URL(string: "\(DarkSkyAPIKey.baseURL)\(DarkSkyAPIKey.apiKey)/") != nil else {
            fatalError("URL can't be empty")
        }
        let cordinate = Coordinate(latitude: "26.876500", longitude: "75.814804")
        client.getCurrentWeather(at: cordinate) { currentWeather,arrDayForcastWeather, error in
            //return data
            if error != nil{
                fatalError("error occor")
            }
            
        }
    }

}
