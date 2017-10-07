@_exported import Vapor

extension Droplet {
    public func setup() throws {
        Base.drop = self
        
        let routes = Routes(view)
        try collection(routes)
    }
}
