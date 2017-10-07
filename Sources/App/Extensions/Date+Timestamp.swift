//
//  Date+Timestamp.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/7/17.
//

import Foundation

extension Date {
    static var timeIntervalSince1970: TimeInterval {
        return timeIntervalBetween1970AndReferenceDate + timeIntervalSinceReferenceDate
    }
}

extension TimeInterval {
    var asTimestamp: String { return String(Int(self)) }
}
