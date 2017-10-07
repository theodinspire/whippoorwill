//
//  Base.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/6/17.
//

import Vapor

final class Base {
    private static var droplet: Droplet?
    
    static var drop: Droplet? {
        get {
            return droplet
        }
        set(newValue) {
            guard droplet == nil else { return }
            droplet = newValue
        }
    }
}
