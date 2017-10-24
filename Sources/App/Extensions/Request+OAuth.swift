//
//  Request+OAuth.swift
//  whippoorwillPackageDescription
//
//  Created by Eric Cormack on 10/8/17.
//

import Foundation
import Vapor
import Cryptor

extension Request {
    func setOAuth1Header(including headerItems: [String: String] = [:]) throws {
//        guard let key = ProcessInfo.processInfo.environment["CONSUMERKEY"],
//            let secret = ProcessInfo.processInfo.environment["CONSUMERSECRET"],
//            let url = "\(uri.scheme)://\(uri.hostname)/\(uri.path)".addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) else {
//                throw Abort.serverError
//        }
//
//        let uniquer = { (_: String, b: String) in b }
//
//        let methodString = "\(method)".uppercased()
//
//        var oauthParameters = [
//            "oauth_consumer_key"      : key,
//            "oauth_nonce"             : UUID().uuidString.replacingOccurrences(of: "-", with: ""),
//            "oauth_signature_method"  : "HMAC-SHA1",
//            "oauth_timestamp"         : Date().timeIntervalSince1970.asTimestamp,
//            "oauth_version"           : "1.0"
//            ].merging(headerItems, uniquingKeysWith: uniquer)
//
//        let signatureParameters = oauthParameters.merging(queryDict, uniquingKeysWith: uniquer)
//
//        var signatureParameterPairs = [(key: String, value: String)]()
//
//        for (k, v) in signatureParameters {
//            guard let key = k.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters),
//                let value = v.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) else {
//                    continue
//            }
//            signatureParameterPairs.append((key, value))
//        }
//
//        signatureParameterPairs.sort { $0.key < $1.key }
//        let signatureParameterString = signatureParameterPairs.map({ "\($0.key)=\($0.value)" }).joined(separator: "&")
//
//        let signatureBaseString = "\(methodString)&\(url)&\(signatureParameterString.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) ?? "")"
//        let signingKey = "\(secret)&\(/* TODO: put session key */"")"
////            "L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg&"
//
////        print("Base string: " + signatureBaseString)
//
//        let hmac = HMAC(using: .sha1, key: Array(signatureBaseString.utf8))
//        let _ = hmac.update(byteArray: Array(signingKey.utf8))
//
//        let signature = hmac.final()
//        print("Signature as [UInt8]: \(signature)")
//        let data = Data(signature).base64EncodedData()
//        print("Signature as Data: \(data)")
//
//        let sigString = String(data: data, encoding: .utf8)
//        oauthParameters["oauth_signature"] = sigString
//        print("Signature as String: \(sigString)")
//
//        let oauthString = oauthParameters.map({ (pair: (key: String, value: String)) -> String in
//            "\(pair.key)=\"\(pair.value)\""
//        }).joined(separator: "\n\t\t")
//
//        headers["Authentication"] = "OAuth\t\(oauthString)"
//
//        print(headers["Authentication"] ?? "No authentication header")
    }
    
    var queryDict: [String: String] {
//        guard let ary = uri.query?.components(separatedBy: "&") else { return [:] }
        var queries = [String: String]()
        
//        for item in ary {
//            let pair = item.components(separatedBy: "=")
//            guard pair.count == 2 else { continue }
//            queries[pair[0]] = pair[1]
//        }
        
        return queries
    }
    
    func baseOAuthParameters(including items: [String: NodeRepresentable] = [:]) throws -> [String: NodeRepresentable] {
        guard let key = ProcessInfo.processInfo.environment["CONSUMERKEY"] else {
            throw Abort.serverError
        }
        
        let base: [String: NodeRepresentable] = [
            "oauth_consumer_key" : key,
            "oauth_nonce" : try Random.makeNonce(),
            "oauth_signature_method" : "HMAC-SHA1",
            "oauth_version" : "1.0",
            "oauth_timestamp" : Date().timeIntervalSince1970.asTimestamp,
        ]
        
        return base.merging(items, uniquingKeysWith: { $1 })
    }
}
