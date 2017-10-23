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
        try request.setOAuth1Header(including: [
            "oauth_callback"          : //Whatever the callback would be?,
                "http%3A%2F%2Flocalhost%2Fsign-in-with-twitter%2F", //  Sign-in
            ])
    
        return request.description
    }
}

//extension HTTPKeyAccessible
