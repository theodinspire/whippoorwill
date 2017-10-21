@_exported import Vapor

extension Droplet {
    public func setup() throws {
        Base.droplet = self
        
        let routes = Routes(view)
        try collection(routes)
    }
}
