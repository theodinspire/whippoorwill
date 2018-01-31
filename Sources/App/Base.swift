//
//  Base.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/6/17.
//

import Vapor

final class Base {
    private static var drop: Droplet?
    private static var twitterClient: ClientProtocol?
    
    static var droplet: Droplet? {
        get {
            return drop
        }
        set(newValue) {
            guard drop == nil else { return }
            drop = newValue
        }
    }
    
    static var twitter: ClientProtocol? {
        get {
            return twitterClient
        }
        set(newValue) {
            guard twitterClient == nil else { return }
            twitterClient = newValue
        }
    }
}
