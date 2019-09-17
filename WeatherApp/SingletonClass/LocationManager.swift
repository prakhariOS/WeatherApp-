//
//  SharedInstance.swift
//  Weather App
//
//  Created by mac on 13/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager:NSObject {
    static let shared: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    private let locationManager = CLLocationManager()
    private weak var location: CLLocation?
    private let geocoder = CLGeocoder()
    private let reachability: Reachability? = Reachability()
    private var getViewController:UIViewController?
    
    private override init(){}
    
    //MARK:- location request  method
    public func requestForLocation(getController:UIViewController){
        getViewController = getController
        locationSetUP()
    }
    
    //MARK:- location enable
    private func locationSetUP() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .denied:
                AlertDialogBox.showAlertForLocation(strMessage: staticMessages.locationSetting, Onview: getViewController!)
            case .authorizedAlways, .authorizedWhenInUse:
                sartLocationWithDelegate()
            case .notDetermined:
                sartLocationWithDelegate()
            case .restricted:
                print("restricted")
            @unknown default:
                fatalError()
            }
        }
        else{
            
        }
    }
    
    private func sartLocationWithDelegate(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    //MARK:- Location Delegates Methods
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if you need to get latest data you can get locations.last to check it if the device has been moved
        let latestLocation = locations.last!
        
        // here check if no need to continue just return still in the same place
        if latestLocation.horizontalAccuracy < 0 {
            return
        }
        // if it location is nil or it has been moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            location = latestLocation
            let latitude:String = String(format:"%f", (location?.coordinate.latitude)!)
            let logitude:String = String(format:"%f", (location?.coordinate.longitude)!)
            
            CacheManager.shared.latitude = latitude
            CacheManager.shared.logitude = logitude
            
            // stop location manager
            // Here is the place you want to start reverseGeocoding
            geocoder.reverseGeocodeLocation(latestLocation, completionHandler: { (placemarks, error) in
                // always good to check if no error
                // also we have to unwrap the placemark because it's optional
                // I have done all in a single if but you check them separately
                if error == nil, let placemark = placemarks, !placemark.isEmpty {
                    var placemrk: CLPlacemark?
                    placemrk = placemark.last
                    if let city = placemrk?.locality, !city.isEmpty {
                        // here you have the city name
                        // assign city name to our iVar
                        
                        CacheManager.shared.CurrentCity = city
                        
                    }
                }
                self.locationManager.stopUpdatingLocation()
                if self.reachability?.connection.description != "No Connection"{
                    self.getViewController!.performSegue(withIdentifier: SequeIdentifier.homeWeatherVC, sender: nil)
                }
                else{
                    AlertDialogBox.showAlert(strMessage: staticMessages.noConnection, Onview: self.getViewController!)
                }
            })
        }
    }
}
