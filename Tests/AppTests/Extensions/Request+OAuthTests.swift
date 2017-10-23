//
//  Request+OAuthTests.swift
//  AppTests
//
//  Created by Eric Cormack on 10/21/17.
//

import XCTest

@testable import Vapor
@testable import App

class Request_OAuthTests: TestCase {
    var sutPost: Request!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBaseOAuthParametersHaveBaseItems() {
        let baseDictionary = Request(method: .get, uri: "https://google.com").baseOAuthParameters()
        
        XCTAssertTrue(baseDictionary.keys.contains("oauth_consumer_key"))
        XCTAssertTrue(baseDictionary.keys.contains("oauth_nonce"))
        XCTAssertTrue(baseDictionary.keys.contains("oauth_signature_method"))
        XCTAssertTrue(baseDictionary.keys.contains("oauth_version"))
        XCTAssertTrue(baseDictionary.keys.contains("oauth_timestamp"))
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
