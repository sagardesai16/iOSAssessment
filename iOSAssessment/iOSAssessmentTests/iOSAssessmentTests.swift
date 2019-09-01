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
    
    /// This function mocks the network call
    /// Network call should succeed which should result in test case success
    
    func testNetworkCall() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        NYAPIUtility.apiRequest(requestType: .mostPopuplarNews, apiData: [:], progessViewTitle: "",paramsForUrl: "7", queryParams: [:] ) { (success, response, statusCode) in
            if success {
                if let jsonResult = response {
                    
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
    
    
    
    /// This function checks for the incorrect parameter sent
    /// Network call should fail which should result in test case failure: As we are only checking for positive results, however this network call returns error (As we are passing *nil* in paramsForUrl which is "Period"
    func testNetworkCallForIncorrectParams() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        NYAPIUtility.apiRequest(requestType: .mostPopuplarNews, apiData: [:], progessViewTitle: "",paramsForUrl: nil, queryParams: [:] ) { (success, response, statusCode) in
            if success {
                if let jsonResult = response {
                    
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
