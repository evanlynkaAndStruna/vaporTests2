//
//  Client.swift
//  App
//
//  Created by Karol on 20/10/2019.
//

import FluentPostgreSQL
import Vapor

final class Client: PostgreSQLModel, Content, Codable, Migration{
    var id: Int?
    var attr1: Int
    var attr2: String
}

extension Client {
    var companies: Children<Client, Company> {
        return children(\.clientID)
    }
}
