//
//  LoginController.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/6/17.
//

import Foundation
import Vapor

final class LoginController {
    func getTest() throws -> String { return try LoginController.getToken() }
    
    private static func getToken() throws -> String {
        let request = Request(method: .post, uri: "https://api.twitter.com/oauth/request_token")
        
        guard let key = ProcessInfo.processInfo.environment["CONSUMERKEY"],
            let secret = ProcessInfo.processInfo.environment["CONSUMERSECRET"] else {
                throw Abort.serverError
        }
    
        let headerInfo = [
            "oauth_callback": "http%3A%2F%2Flocalhost%2Finfo%2F",
            "oauth_consumerkey": key,
            "oauth_consumersecret": secret,
            "oauth_nonce": "ThisShouldBeNothing",
            "oauth_signature_method": "HMAC-SHA1",
            "oauth_timestamp": Date.timeIntervalSince1970.asTimestamp,
            "oauth_version": "1.0"
        ]
    
        request.headers["Authorization"] = ""
    
        return request.description
    }
}

//extension HTTPKeyAccessible
