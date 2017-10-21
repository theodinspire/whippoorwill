//
//  Base.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/6/17.
//

import Vapor

final class Base {
    private static var drop: Droplet?
    
    static var droplet: Droplet? {
        get {
            return drop
        }
        set(newValue) {
            guard drop == nil else { return }
            drop = newValue
        }
    }
}
