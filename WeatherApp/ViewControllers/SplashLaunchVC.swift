//
//  SplashLaunchVC.swift
//  WeatherApp
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit
//import CoreLocation

class SplashLaunchVC: UIViewController {

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // location manager intialization
        locationManagerInitialization()
        // Notifiy for location
        NotificationCenter.default.addObserver(self, selector:#selector(checkLocationSetUp), name:
            UIApplication.willEnterForegroundNotification, object: nil)
    }
    private func locationManagerInitialization(){
        LocationManager.shared.requestForLocation(getController:self)
    }
    
    @objc private func checkLocationSetUp(){
        //locationSetUP()
        locationManagerInitialization()
    }
    
}

