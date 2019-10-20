//
//  CompanyController.swift
//  App
//
//  Created by Karol on 20/10/2019.
//

import Vapor
import FluentPostgreSQL

final class CompanyController : RouteCollection{
    func boot(router: Router) throws {
        let posts = router.grouped("companies")
        posts.post(use: post)
        posts.get(use: get)
    }
    
    func post(_ req: Request) throws -> Future<Company2> {
       return try req.content.decode(Company2.self).flatMap {cl in
           return cl.create(on: req)
       }
    }
    
    func get(_ req: Request) throws -> Future<[Company2]> {
        return Company2.query(on: req).all()
    }
}
