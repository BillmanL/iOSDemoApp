//
//  APIClient.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-19.
//

import Foundation

protocol APIClient {
    func getMovies() async throws -> [Movie]
    func getUsers() async throws -> [User]
}

class DemoAPIClient: APIClient {
    let networkLayerClient: NetworkLayerClient = NetworkLayerClient()
    
    func getMovies() async throws -> [Movie] {
        return try await networkLayerClient.requestDecodable(router: .GetMovies, model: [Movie].self)
    }
    
    func getUsers() async throws -> [User] {
        return try await networkLayerClient.requestDecodable(router: .GetUsers, model: [User].self)
    }
}

enum AppEnvironment {
    case prod
    case mock
}

class DemoAPI {
    static let shared: DemoAPI = DemoAPI()
    
    var environment: AppEnvironment = .prod
    var client: APIClient {
        return environment == .mock ? MockAPIClient() : DemoAPIClient()
    }
}
