//
//  TimeInterval+Timestamp.swift
//  whippoorwill
//
//  Created by Eric Cormack on 10/7/17.
//

import Foundation

extension TimeInterval {
    var asTimestamp: String { return String(Int(self)) }
}
