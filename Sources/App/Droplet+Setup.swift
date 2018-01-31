@_exported import Vapor
import TLS

extension Droplet {
    public func setup() throws {
        Base.droplet = self
        Base.twitter = try self.client.makeClient(hostname: "api.twitter.com", port: 443, securityLayer: .tls(TLS.Context(.client)))
        
        let routes = Routes(view)
        try collection(routes)
    }
}
