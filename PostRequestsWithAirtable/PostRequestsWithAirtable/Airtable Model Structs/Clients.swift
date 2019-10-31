//
//  Clients.swift
//  PostRequestsWithAirtable
//
//  Created by Radharani Ribas-Valongo on 10/31/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ClientWrapper: Codable {
    let records: [Clients]
}

struct Clients: Codable {
    let fields: Fields
    
    static func getClients(from jsonData: Data) throws -> [Clients] {
        let response = try JSONDecoder().decode(ClientWrapper.self, from: jsonData)
        return response.records
    }
}

struct Fields: Codable {
    let name: String?
    let about: String?
    let logo: [Logo]?
    
    enum CodingKeys: String, CodingKey {
        case about = "About"
        case name = "Name"
        case logo = "Logo"
    }
}

struct Logo: Codable {
    let url: String?
}
