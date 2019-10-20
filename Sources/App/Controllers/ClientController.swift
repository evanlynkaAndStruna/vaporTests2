import Vapor
import FluentPostgreSQL

/// Controls basic CRUD operations on `Todo`s.
final class ClientController : RouteCollection{
    func boot(router: Router) throws {
        let posts = router.grouped("clients")
        posts.get(use: get)
        posts.post(use: post)
    }
    
    func get(_ req: Request) throws -> Future<[ClientResponse]> {
        return Client.query(on: req).all().flatMap { clients in
            let clientResponseFutures = try clients.map { client in
                try client.companies.query(on: req).all().map { companies in
                    return ClientResponse(client: client, companies: companies)
                }
            }

            return clientResponseFutures.flatten(on: req)
            }
    }
    
    func post(_ req: Request) throws -> Future<Client> {
       return try req.content.decode(Client.self).flatMap {client in
           return client.create(on: req)
       }
    }
}

struct ClientResponse: Content {
    let client: Client
    let companies: [Company]
}

//curl -H "Content-Type: application/json" -X POST -d '{"id": 2, "title": "ksiazka1"}' http://localhost:8080/todos
