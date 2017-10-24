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
    func testMakeNonce() {
        do { let _ = try Random.makeNonce()
        } catch { XCTFail() }
    }
}
