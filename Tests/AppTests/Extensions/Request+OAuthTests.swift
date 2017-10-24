//
//  Request+OAuthTests.swift
//  AppTests
//
//  Created by Eric Cormack on 10/21/17.
//

import XCTest
import Vapor

@testable import App

class Request_OAuthTests: XCTestCase {
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
        do {
            let baseDictionary = try Request(method: .get, uri: "https://api.twitter.com").baseOAuthParameters()
            
            XCTAssertTrue(baseDictionary.keys.contains("oauth_consumer_key"))
            XCTAssertTrue(baseDictionary.keys.contains("oauth_nonce"))
            XCTAssertTrue(baseDictionary.keys.contains("oauth_signature_method"))
            XCTAssertTrue(baseDictionary.keys.contains("oauth_version"))
            XCTAssertTrue(baseDictionary.keys.contains("oauth_timestamp"))
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersHaveConsumerKey() {
        do {
            let baseDictionary = try Request(method: .get, uri: "https://api.twitter.com").baseOAuthParameters()
            guard let envKey = ProcessInfo.processInfo.environment["CONSUMERKEY"], let oauthKey = baseDictionary["oauth_consumer_key"] as? String else {
                throw Abort.serverError
            }
            
            XCTAssertEqual(envKey, oauthKey)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParamatersSignatureMethodIsHMACSHA1() {
        do {
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            guard let signatureMethod = baseDictionary["oauth_signature_method"] as? String else { throw Abort.serverError }
            
            XCTAssertEqual("HMAC-SHA1", signatureMethod)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersOAuthVersionIs1() {
        do {
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            guard let signatureMethod = baseDictionary["oauth_version"] as? String else { throw Abort.serverError }
            
            XCTAssertEqual("1.0", signatureMethod)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersTimestampIsCurrent() {
        do {
            let earlier = Date().timeIntervalSince1970.asTimestamp
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            let later = Date().timeIntervalSince1970.asTimestamp
            
            guard let timestamp = baseDictionary["oauth_timestamp"] as? String else { throw Abort.serverError }
            
            XCTAssertLessThanOrEqual(earlier, timestamp)
            XCTAssertLessThanOrEqual(timestamp, later)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersInputDictionaryOverridesBase() {
        do {
            let replacement = "🌙🐉🏉💫"
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters(including: ["oauth_nonce": replacement])
            guard let nonce = baseDictionary["oauth_nonce"] as? String else { throw Abort.serverError }
            
            XCTAssertEqual(replacement, nonce)
        } catch {
            XCTFail()
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
