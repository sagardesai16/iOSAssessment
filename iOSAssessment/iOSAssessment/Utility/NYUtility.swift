//
//  NYUtility.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit
import MBProgressHUD


class NYUtility: NSObject {
    
    
    @discardableResult class func showGlobalProgressHUDWithTitle(title: String) -> MBProgressHUD {
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        let hud = MBProgressHUD.showAdded(to: window!, animated: true)
        hud.label.text = title
        hud.bezelView.color = UIColor.black.withAlphaComponent(0.4)
        hud.contentColor = UIColor.white
        return hud
    }
    
    class func dismissGlobalHUD() -> Void {
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        MBProgressHUD.hide(for: window!, animated: true)
    }
    
    
  
    class func appAvailable(scheme: String) -> Bool {
        if let url = NSURL.init(string: scheme) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
        return false
    }
    
    
}

