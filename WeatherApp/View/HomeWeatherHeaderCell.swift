//
//  HomeWeatherHeaderCell.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit

class HomeWeatherHeaderCell: UITableViewCell {
    
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblTempreature: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    var item: CurrentWeatherViewModel?{
        didSet {
            lblLocation.text = item?.timezone
            imgWeather.image = item?.icon
            lblTempreature.text = item?.temperature
            lblSummary.text = item?.summary
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
