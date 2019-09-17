//
//  APIErrors.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation

enum DarkSkyAPIError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case invalidUrl
    case jsonConversionFailure
    case jsonParsingFailure
}

