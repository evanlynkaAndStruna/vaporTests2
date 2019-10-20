//
//  Company.swift
//  App
//
//  Created by Karol on 20/10/2019.
//

import FluentPostgreSQL
import Vapor

final class Company2: PostgreSQLUUIDModel, Content, Codable, Migration{
    init(name: String, clientID : Client.ID) {
        self.name = name
        self.clientID = clientID
    }
    
    var id: UUID?
    var name: String
    var clientID : Client.ID
}

extension Company2 {
    var companies: Parent<Company2, Client> {
        return parent(\.clientID)
    }
}

//struct CompanyBody: Content {
//    let contents: String
//
//    func model(with id: User.ID) -> Post {
//        return Post(contents: self.contents, userID: id)
//    }
//}
