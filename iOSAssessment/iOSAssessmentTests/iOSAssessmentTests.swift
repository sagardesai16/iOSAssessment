//
//  iOSAssessmentTests.swift
//  iOSAssessmentTests
//
//  Created by Sagar Desai on 31/08/19.
//  Copyright © 2019 Sagar Desai. All rights reserved.
//

import XCTest
@testable import iOSAssessment

class iOSAssessmentTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkCall() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        NYAPIUtility.apiRequest(requestType: .mostPopuplarNews, apiData: [:], progessViewTitle: "",paramsForUrl: "7", queryParams: [:] ) { (success, response, statusCode) in
            if success {
                if let jsonResult = response  as? [String: Any] {
                    
                    if let results = jsonResult["results"] as? [jsonDict] {
                        XCTAssertNotNil(results)
                        ex.fulfill()
                    }
                }
                
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testNetworkCallForIncorrectParams() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        NYAPIUtility.apiRequest(requestType: .mostPopuplarNews, apiData: [:], progessViewTitle: "",paramsForUrl: nil, queryParams: [:] ) { (success, response, statusCode) in
            if success {
                if let jsonResult = response  as? [String: Any] {
                    
                    if let results = jsonResult["results"] as? [jsonDict], results.count > 0 {
                        XCTAssertNotNil(results)
                        ex.fulfill()
                    }
                }
                
            }
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }


}
