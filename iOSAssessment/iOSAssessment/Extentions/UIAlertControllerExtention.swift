//
//  UIAlertControllerExtention.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    
    class func showAlert(titleString: String?, messageString: String?, viewController: UIViewController?=nil) {
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        
        if (viewController != nil) {
            viewController!.present(alertController, animated: true, completion: nil)
            
        } else {
            let window:UIWindow = (UIApplication.shared.delegate as! AppDelegate).window!
            
            let vc = window.rootViewController?.presentedViewController ?? window.rootViewController
            vc?.present(alertController, animated: true, completion: nil)
            
        }
        
//         alertController.view.tintColor = UIColor(hexString: "FFFFFF")
    }
    
    
}
