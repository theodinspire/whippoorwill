//
//  Random+NonceTests.swift
//  AppTests
//
//  Created by Eric Cormack on 10/23/17.
//

import XCTest

import Cryptor

@testable import App

class Random_NonceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMakeNonce() {
        do {
            let nonce = try Random.makeNonce()
        } catch {
            XCTFail()
        }
    }

}
