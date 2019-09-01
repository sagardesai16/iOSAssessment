//
//  NYNetworManager.swift
//  iOSAssessment
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

typealias jsonDict = [String:Any]

struct HttpStatusCode {
    
    /* 2xx Success */
    static let success              = 200
    static let created              = 201
    
    /* 4xx Client Error */
    static let badRequest           = 400   // Missing required params
    static let unauthorized         = 401   // Invalid or expired access token
    static let forbidden            = 403   // Do not have access to the requested resource
    static let unprocessableEntity  = 400   // Unprocessable Entity params
    
    static let notFound             = 404   // When requested data is empty
    static let methodNotAllowed     = 405
    static let conflict             = 409
    
    /* 5xx Server Error */
    static let internalServerError  = 500
    
}

struct APIUrl {
    
    /* Base URL */
    
    struct staging {
        static let baseUrl  = "https://api.nytimes.com/svc/mostpopular/v2/"
    }

    /* APIs Url */
    static let mostPopuplarNews = "mostviewed/all-sections/"

}

struct NYServer {
    
    struct staging {
        static let apiKey = "cjImi071AkYyckXBfcGMJ66b4536EBOt"
    }
    
    struct development {
        static let apiKey = "cjImi071AkYyckXBfcGMJ66b4536EBOt"
    }

}

enum VPRequestType: Int {
    
    
    case mostPopuplarNews
    
    private func getRelativeUrl(param: String? = nil) -> String {
        
        switch self {
        case .mostPopuplarNews: return APIUrl.mostPopuplarNews + (param ?? "") + ".json?api-key=" + NYServer.staging.apiKey
        }
    }
    
    func getBaseUrl() -> String{
        
        return APIUrl.staging.baseUrl
 
    }
    
    func getFullUrl(param: String? = nil, queryParams:jsonDict? = nil) -> String {
        
        let parameters = queryParams ?? jsonDict()
        
        if !parameters.isEmpty {
            var queryParameters = ""
            for (key, value) in parameters {
                queryParameters =  queryParameters + "&\(key)=\((value as! String).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")"
            }
            
            return getBaseUrl() + getRelativeUrl(param: param) + queryParameters
        }
        return getBaseUrl() + getRelativeUrl(param: param)
    }
    
    func getEncoding() -> Alamofire.ParameterEncoding {
        
        switch self {
        case .mostPopuplarNews :
            return  URLEncoding.default
        }
        
    }
    
    func getMethodType() -> HTTPMethod {
        
        switch self {
        case .mostPopuplarNews:
            
            return .get
            
        }
        
    }
}

class NYAPIUtility: NSObject {
    class var configuration: URLSessionConfiguration {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // In seconds
        configuration.timeoutIntervalForResource = 60
        
        return configuration
    }
    
    class var headers: [String: String] {
        let headers = ["content-type": "Application/json"]
        return headers
    }
    
    /// API Call to the server
    ///
    /// - Parameters:
    ///   - requestType: type of the request that already defined as PTRequestType enum
    ///   - apiData: params/body for post method
    ///   - progessViewTitle: ProgressHUD title, pass nil if you do not want to show the ProgressHUD
    ///   - paramsForUrl: custom params for URL for GET api call
    ///   - completion: completion block
    class func apiRequest(requestType:VPRequestType, apiData: Parameters, progessViewTitle:String? = nil, paramsForUrl: String? = nil, queryParams:jsonDict?=nil, completion:@escaping (_ success: Bool, _ response: jsonDict?, _ statusCode:Int) ->Void) {
        
        guard NYConnectivity.isConnectedToInternet else {
            UIAlertController.showAlert(titleString: "Alert", messageString: NYError.GenericError.noInternetConnection)
            completion(false, nil, -1)
            return
        }
        
       UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // Progress View
        var progressHUD:MBProgressHUD? = nil
        
        if progessViewTitle != nil && progessViewTitle != "hide" {
            progressHUD = NYUtility.showGlobalProgressHUDWithTitle(title: progessViewTitle!)
        }
        
        let requestURL = (requestType.getFullUrl(param: paramsForUrl,queryParams: queryParams) as String)
     
        AF.request(requestURL)
            .responseJSON(completionHandler: { (response:DataResponse<Any>) in
                
                // Hide progress hud
                progressHUD?.hide(animated: true)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
                switch(response.result) {
                case .success(let data):
                    if let jsonResult = data  as? [String: Any] {
                        
                        if let status = jsonResult["status"] as? String, status == "OK" {
                            if let _ = jsonResult["results"] as? [jsonDict] {
                                completion(true, jsonResult, (response.response?.statusCode)!)
                            }
                        } else {
                                completion(false, jsonResult, (response.response?.statusCode)!)
                        }
                    }
                
                    break
                case .failure(let errorData):
                    completion(false, errorData as? jsonDict, response.response?.statusCode ?? -1)
                    
                    break
                }
            })
        
        
    }

    
}



