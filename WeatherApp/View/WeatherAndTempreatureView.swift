//
//  WeatherAndTempreatureViewModel.swift
//  Weather App
//
//  Created by mac on 08/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit

//MARK:- protocol
protocol WeatherAndTempreatureDelegate:class {
    func darkSkyApiCalledCompleted(sendCurrentWeathertoUpdateUI:CurrentWeatherViewModel)
    func darkAPiError()
    func noConnectionFound()
    
}

class WeatherAndTempreatureView: NSObject {
    //MARK:- objects
    var delegate:WeatherAndTempreatureDelegate?
    var dataSource = [DayForcastViewModel]()
    var currentWeatherGet:CurrentWeatherViewModel?
    let zeroIndex = 0
    let noConnection = "No Connection"
    let reachability: Reachability? = Reachability()
    
    static let shared = WeatherAndTempreatureView()
    
    // MARK: API method
    func apiCallWeather(getTableview:UITableView) {
        let locationCoordinate = Coordinate(latitude: CacheManager.shared.latitude, longitude: CacheManager.shared.logitude)
        if reachability?.connection.description != noConnection {
            getTableview.delegate = self
            getTableview.dataSource = self
            fetchWeatherResult(for: locationCoordinate)
        }
        else{
            self.delegate?.noConnectionFound()
        }
    }
    
    private func fetchWeatherResult(for coordinate: Coordinate) {
        DarkSkyAPIClient.shared.getCurrentWeather(at: coordinate) { [unowned self] currentWeather,arrDayForcastWeather, error in
            if error != nil {
                self.delegate?.darkAPiError()
                return
            }
            guard let item = arrDayForcastWeather else {return}
            
            self.dataSource.removeAll()
            self.dataSource = item.map({ return DayForcastViewModel(from: $0) })
            
            self.currentWeatherGet = CurrentWeatherViewModel(from: currentWeather!)
            
            self.delegate?.darkSkyApiCalledCompleted(sendCurrentWeathertoUpdateUI: self.currentWeatherGet!)
            
            
        }
    }
}

//MARK:- table view delegate methods
extension WeatherAndTempreatureView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == zeroIndex {
            return CGFloat(TableHeight.tableHeader)
        }
        else{
            return CGFloat(TableHeight.tableList)
            
        }
    }
    
}
//MARK:- table view data source methods

extension WeatherAndTempreatureView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == zeroIndex {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.homeWeatherCellIdentifier) as? HomeWeatherHeaderCell else {return UITableViewCell()}
            cell.item = currentWeatherGet
            return cell
        }
        else{
            let item = dataSource[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.weatherListCellIdentifier) as? WeatherListCell else {return UITableViewCell()}
            cell.item = item
            return cell
        }
        
    }
}

