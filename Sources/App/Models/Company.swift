//
//  Company.swift
//  App
//
//  Created by Karol on 20/10/2019.
//

import FluentPostgreSQL
import Vapor

final class Company: PostgreSQLModel, Content, Codable, Migration{
    init(id: Int?, name: String, clientID : Client.ID) {
        self.id = id
        self.name = name
        self.clientID = clientID
    }
    
    var id: Int?
    var name: String
    var clientID : Client.ID
}

extension Company {
    var companies: Parent<Company, Client> {
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
