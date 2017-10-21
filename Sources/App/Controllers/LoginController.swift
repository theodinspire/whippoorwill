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
    
        
    
        request.headers["Authorization"] = ""
    
        return request.description
    }
}

//extension HTTPKeyAccessible
