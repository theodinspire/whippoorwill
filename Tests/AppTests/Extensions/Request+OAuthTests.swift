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
    
    //  func baseOAuthParamters(including:) -> [String: String]
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
            guard let envKey = ProcessInfo.processInfo.environment["CONSUMERKEY"], let oauthKey = baseDictionary["oauth_consumer_key"] else { throw Abort.serverError }
            
            XCTAssertEqual(envKey, oauthKey)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParamatersSignatureMethodIsHMACSHA1() {
        do {
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            guard let signatureMethod = baseDictionary["oauth_signature_method"] else { throw Abort.serverError }
            
            XCTAssertEqual("HMAC-SHA1", signatureMethod)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersOAuthVersionIs1() {
        do {
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            guard let signatureMethod = baseDictionary["oauth_version"] else { throw Abort.serverError }
            
            XCTAssertEqual("1.0", signatureMethod)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersTimestampIsCurrent() {
        do {
            let earlier = trunc(Date().timeIntervalSince1970)
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters()
            let later = trunc(Date().timeIntervalSince1970)
            
            guard let timestamp = baseDictionary["oauth_timestamp"], let time = TimeInterval(timestamp) else { throw Abort.serverError }
            
            XCTAssertLessThanOrEqual(earlier, time)
            XCTAssertLessThanOrEqual(time, later)
        } catch {
            XCTFail()
        }
    }
    
    func testBaseOAuthParametersInputDictionaryOverridesBase() {
        do {
            let replacement = "🌙🐉🏉💫"
            let baseDictionary = try Request(method: .get, uri: "http://api.twitter.com").baseOAuthParameters(including: ["oauth_nonce": replacement])
            guard let nonce = baseDictionary["oauth_nonce"] else { throw Abort.serverError }
            
            XCTAssertEqual(replacement, nonce)
        } catch {
            XCTFail()
        }
    }

    //  var queryDictionary: [String: String]
    func testQueryDictionaryQuerylessURLMakesEmptyDictionary() {
        let request = Request(method: .post, uri: "https://api.twitter.com/oauth/request_token")
        XCTAssertTrue(request.queryDictionary.isEmpty)
    }
    
    func testQueryDictionaryURLWithQueriesProducesDictionary() {
        let url = "https://api.twitter.com/oauth/authenticate"
        let key = "oauth_token"
        let value = "NPcudxy0yU5T3tBzho7iCotZ3cnetKwcTIRlX0iwRl0"
        
        let request = Request(method: .get, uri: "\(url)?\(key)=\(value)")
        
        XCTAssertEqual(request.queryDictionary[key], value)
    }
}
