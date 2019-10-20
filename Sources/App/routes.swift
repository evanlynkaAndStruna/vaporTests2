import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Example of configuring a controller
    try router.register(collection: ClientController())
    try router.register(collection: CompanyController())
}
