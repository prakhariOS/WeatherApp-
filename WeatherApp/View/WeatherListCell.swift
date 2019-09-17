//
//  WeatherListCell.swift
//  Weather App
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    
    @IBOutlet weak var lblHuminity: UILabel!
    @IBOutlet weak var lblMinAndMax: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblDay: UILabel!
    
    var item: DayForcastViewModel? {
        didSet {
            lblDay.text = item?.date
            let strMax = String(format: "%d", item!.temperatureMax.int())
            let strMin = String(format: "%d", item!.temperatureMin.int())
            lblMinAndMax.text = MiscellaneousKey.max + strMax + MiscellaneousKey.celcius + MiscellaneousKey.nextline + MiscellaneousKey.min + strMin + MiscellaneousKey.celcius
            let strHumid = String(format: "%d%@", item!.humidity,"%")
            lblHuminity.text = strHumid
            imgIcon.image = item?.icon
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
