//
//  NYConnectivity.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import Foundation
import Alamofire

class NYConnectivity {
    
    /// Uses the class NetworkReachabilityManager of Alamofire to determine if network is available or not
    ///
    /// - Returns: Boolean status of the network reachbility
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
