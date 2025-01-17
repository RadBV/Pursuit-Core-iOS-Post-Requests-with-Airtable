//
//  ClientAPIHelper.swift
//  PostRequestsWithAirtable
//
//  Created by Radharani Ribas-Valongo on 10/31/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

class ClientAPIHelper {
    private init() {}
    static let shared = ClientAPIHelper()
    private var airtableURL: URL {
        guard let url = URL(string: "https://api.airtable.com/v0/" + Secrets.AirtableProject + "/Clients?view=All%20clients&api_key=" + Secrets.AirtableAPIKey) else {
            fatalError("Error: Invalid URL")
        }
        return url
    }
    
    func getClients(completionHandler: @escaping (Result<[Clients],AppError>) -> Void ) {
        
        NetworkHelper.manager.performDataTask(withUrl: airtableURL, andMethod: .get) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(appError))
            case .success(let data):
                do {
                    let ClientData = try Clients.getClients(from: data)
                    completionHandler(.success(ClientData))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    func post(_ client: Clients , completionHandler: @escaping (Result<Data, AppError>) -> Void) {
        guard let encodedClientWrapper = try? JSONEncoder().encode(client) else {
            fatalError("Unable to json encode project")
        }
        print(String(data: encodedClientWrapper, encoding: .utf8)!)
        NetworkHelper.manager.performDataTask(withUrl: airtableURL,
                                              andHTTPBody: encodedClientWrapper,
                                              andMethod: .post,
                                              completionHandler: { result in
                                                switch result {
                                                case let .success(data):
                                                    completionHandler(.success(data))
                                                case let .failure(error):
                                                    completionHandler(.failure(error))
                                                }
        })
    }
}
