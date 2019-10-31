//
//  Clients.swift
//  PostRequestsWithAirtable
//
//  Created by Radharani Ribas-Valongo on 10/31/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ClientWrapper: Codable {
    let fields: [Clients]
}

struct Clients: Codable {
    let fields: Fields
    
}
struct Fields: Codable {
    let Name: String
    let About: String
    let Logo: [Logo]?
    
    static func getClients(from jsonData: Data) throws -> [Clients] {
        let response = try JSONDecoder().decode(ClientWrapper.self, from: jsonData)
        return response.fields
    }
}


//Wrappers

struct Logo: Codable {
    let thumbnails: Thumbnails
}

struct Thumbnails: Codable {
    let large: Large
}

struct Large: Codable {
    let url: String
}
