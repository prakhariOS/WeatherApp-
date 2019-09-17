//
//  AlertDialogBox.swift
//  WeatherApp
//
//  Created by mac on 07/09/19.
//  Copyright © 2019 weather.app.com. All rights reserved.
//

import UIKit


class AlertDialogBox: NSObject {
    //MARK:- Alert popup
    class func showAlertForLocation( strMessage : String , Onview : UIViewController)
    {
        if Onview.navigationController != nil {
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: staticMessages.title, message: strMessage, preferredStyle: UIAlertController.Style.alert)
                
                // Button to Open Settings
                alert.addAction(UIAlertAction(title: staticMessages.setting, style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: staticMessages.cancel, style: UIAlertAction.Style.default, handler:{
                    action in
                    Onview.dismiss(animated: true, completion: nil)
                }))
                Onview.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // function to set show alert
    class func showAlert( strMessage : String , Onview : UIViewController)
    {
        if Onview.navigationController != nil {
            
            DispatchQueue.main.async {
                
                let alertController = UIAlertController(title: staticMessages.title as String, message: strMessage as String, preferredStyle: UIAlertController.Style.alert)
                
                alertController.addAction(UIAlertAction(title: staticMessages.ok, style: UIAlertAction.Style.default,handler: nil))
                
                Onview.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}


