import Vapor

final class Routes: RouteCollection {
    let view: ViewRenderer
    let login = LoginController()
    init(_ view: ViewRenderer) {
        self.view = view
    }

    func build(_ builder: RouteBuilder) throws {
        /// GET /
        builder.get { req in
            return try self.view.make("welcome")
        }
        
        /// GET /login/
        builder.get("login") { req in
            return try self.login.getTest()
        }

        /// GET /hello/...
        builder.resource("hello", HelloController(view))

        // response to requests to /info domain
        // with a description of the request
        builder.get("info") { req in
            return req.description
        }

    }
}
