//
//  Random+Nonce.swift
//  whippoorwillPackageDescription
//
//  Created by Eric Cormack on 10/23/17.
//

import Foundation
import Cryptor

extension Random {
    static func makeNonce() throws -> String {
        return try Data(generate(byteCount: 32)).base64EncodedString().components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }
}
