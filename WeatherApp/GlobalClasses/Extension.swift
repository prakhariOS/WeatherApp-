//
//  Extension.swift
//  Weather App
//
//  Created by mac on 08/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Rounds the double to decimal places value and percent,integer,temp to celcius
extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func calculateTempToCelcius(tempreature:Double) -> Double {
        return ((tempreature - 32) * 5)/9
    }
    func percent() -> Double {
        return self * 100
    }
    
    func int() -> Int {
        return Int(self)
    }
}

// MARK: - Date Extension to covert date to a day in String type.
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
// MARK: - tableview animation extension
extension UITableView {
    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
