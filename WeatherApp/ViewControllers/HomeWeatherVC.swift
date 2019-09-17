//
//  HomeWeatherVC.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit

class HomeWeatherVC: UIViewController {
    // MARK: UI Objects
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblPreciption: UILabel!
    @IBOutlet weak var imgCloud: UIImageView!
    @IBOutlet weak var lblRainPercent: UILabel!
    @IBOutlet weak var lblHumityPrcnt: UILabel!
    @IBOutlet weak var lblTemprature: UILabel!
    @IBOutlet weak var lblOverCast: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblviewCurrentLocation: UITableView!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var btnUnitateState: UIButton!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    
    
    // MARK: bacgground color Object
    let backgroundColor = UIColor.init(red: 255.0/255.0, green: 160.0/255.0, blue: 17.0/255.0, alpha: 1.0)
    
    //MARK:- view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        activityIndicator.startAnimating()
        
        //self.viewModel = WeatherAndTempreatureViewModel.init()
        WeatherAndTempreatureView.shared.apiCallWeather(getTableview:tblviewCurrentLocation)
        WeatherAndTempreatureView.shared.delegate = self
    }
    //MARK:- Register Cells
    private func registerCells(){
        tblviewCurrentLocation.register(UINib(nibName: NibFile.weatherListCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.weatherListCellIdentifier)
        tblviewCurrentLocation.register(UINib(nibName: NibFile.homeWeatherCell, bundle: nil), forCellReuseIdentifier: CellIdentifiers.homeWeatherCellIdentifier)
    }
    //MARK:- animation stop
    private func stopAnimating(){
        activityIndicator.stopAnimating()
    }
    
    //MARK:- slide View horizontaly
    private func slideViewHorizontaly(){
        let pageWidth:CGFloat = self.scrlView.frame.width
        let maxWidth:CGFloat = pageWidth * 2
        let contentOffset:CGFloat = self.scrlView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrlView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrlView.frame.height), animated: true)
    }
    
    //MARK:- Button action methods
    
    @IBAction func btnCurrentLocationTaped(_ sender: UIButton) {
        sender.backgroundColor = backgroundColor
        sender.titleLabel?.textColor = UIColor.white
        btnUnitateState.backgroundColor = UIColor.clear
        btnUnitateState.titleLabel?.textColor = UIColor.gray
        if self.scrlView.contentOffset.x > 0{
            slideViewHorizontaly()
        }
    }
    @IBAction func btnUSTaped(_ sender: UIButton) {
        sender.backgroundColor = backgroundColor
        sender.setTitleColor(UIColor.white, for: .normal)
        btnCurrentLocation.backgroundColor = UIColor.clear
        btnCurrentLocation.titleLabel?.textColor = UIColor.gray
        if self.scrlView.contentOffset.x == 0 {
            slideViewHorizontaly()
        }
    }
}

//MARK:- custom Delegates methods
extension HomeWeatherVC:WeatherAndTempreatureDelegate{
    func darkSkyApiCalledCompleted(sendCurrentWeathertoUpdateUI: CurrentWeatherViewModel) {
        stopAnimating()
        lblTemprature.text = sendCurrentWeathertoUpdateUI.temperature
        lblHumityPrcnt.text = sendCurrentWeathertoUpdateUI.humidity
        lblRainPercent.text = sendCurrentWeathertoUpdateUI.precipitationProbability
        lblOverCast.text = sendCurrentWeathertoUpdateUI.summary
        lblLocation.text = sendCurrentWeathertoUpdateUI.timezone
        imgCloud.image = sendCurrentWeathertoUpdateUI.icon
        lblWind.text = sendCurrentWeathertoUpdateUI.wind
        lblPreciption.text = sendCurrentWeathertoUpdateUI.preciptitation
        self.tblviewCurrentLocation.reloadWithAnimation()
    }
    
    func darkAPiError() {
        stopAnimating()
        AlertDialogBox.showAlert(strMessage: staticMessages.error, Onview: self)
    }
    func noConnectionFound(){
        stopAnimating()
        AlertDialogBox.showAlert(strMessage: staticMessages.noConnection, Onview: self)
    }
}
