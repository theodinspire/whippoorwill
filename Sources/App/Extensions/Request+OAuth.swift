//
//  OAuthRequest.swift
//  whippoorwillPackageDescription
//
//  Created by Eric Cormack on 10/8/17.
//

import Foundation
import Vapor
import Cryptor

extension Request {
    func setOAuth1Header(including headerItems: [String: String] = [:]) throws {
        guard let key = ProcessInfo.processInfo.environment["CONSUMERKEY"],
            let secret = ProcessInfo.processInfo.environment["CONSUMERSECRET"],
            let url = "\(uri.scheme)://\(uri.hostname)/\(uri.path)".addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) else {
                throw Abort.serverError
        }
        
        let uniquer = { (a: String, _: String) in a }
        
        let methodString = "\(method)".uppercased()
        
        var oauthParameters = [
            "oauth_consumer_key"      : key,
            "oauth_nonce"             : UUID().uuidString.replacingOccurrences(of: "-", with: ""),
            "oauth_signature_method"  : "HMAC-SHA1",
            "oauth_timestamp"         : Date.timeIntervalSince1970.asTimestamp,
            "oauth_version"           : "1.0"
            ]
        
        let signatureParameters = oauthParameters.merging(headerItems, uniquingKeysWith: uniquer).merging(queryDict, uniquingKeysWith: uniquer)
        
        var signatureParameterPairs = [(key: String, value: String)]()
        
        for (k, v) in signatureParameters {
            guard let key = k.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters),
                let value = v.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) else {
                    continue
            }
            signatureParameterPairs.append((key, value))
        }
        
        signatureParameterPairs.sort { $0.key < $1.key }
        let signatureParameterString = signatureParameterPairs.map({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        
        let signatureBaseString = "\(methodString)&\(url)&\(signatureParameterString.addingPercentEncoding(withAllowedCharacters: .OAuth1AllowedCharacters) ?? "")"
        let signingKey = "\(secret)&\(/* TODO: put session key */"")"
        
        print(signatureBaseString)
        
        let hmac = HMAC(using: .sha1, key: Array(signatureBaseString.utf8))
        let _ = hmac.update(byteArray: Array(signingKey.utf8))
        
        let signature = hmac.final()
        
        oauthParameters["oauth_signature"] = String(data: Data(signature), encoding: .utf8)
        
        let oauthString = oauthParameters.map({ (pair: (key: String, value: String)) -> String in
            "\(pair.key)=\"\(pair.value)\""
        }).joined(separator: "\n\t\t")
        
        headers["Authenication"] = "OAuth\t\(oauthString)"
    }
    
    private var queryDict: [String: String] {
        guard let ary = uri.query?.components(separatedBy: "&") else { return [:] }
        var queries = [String: String]()
        
        for item in ary {
            let pair = item.components(separatedBy: "=")
            guard pair.count == 2 else { continue }
            queries[pair[0]] = pair[1]
        }
        
        return queries
    }
}
