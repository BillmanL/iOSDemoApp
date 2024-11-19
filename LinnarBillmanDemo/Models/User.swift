//
//  User.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

struct Address: Codable, Equatable, Hashable {
    let street: String
    let city: String
    let state: String
    let zipcode: String
}

struct User: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address?
}

extension User {
    static func fetchDataFromBackend() async throws -> [User] {
        return try await DemoAPI.shared.client.getUsers()
    }
    
    static func getDataFromUserDefaults() -> [User] {
        return UserDefaultsHelper.getDecodableDataFromUserDefaults(for: .users, model: [User].self) ?? []
    }
    
    static func saveDataToUserDefaults(_ users: [User]) {
        UserDefaultsHelper.saveCodableDataToUserDefaults(users, for: .users)
        User.saveCacheTimeStamp()
    }
    
    static func clearDataFromUserDefaults() {
        UserDefaultsHelper.clearDataFromUserDefaults(for: .users)
        UserDefaultsHelper.clearDataFromUserDefaults(for: .usersCacheTimeStamp)
    }
    
    static func saveCacheTimeStamp() {
        UserDefaultsHelper.saveCacheTimeStamp(for: .usersCacheTimeStamp)
    }
    
    static func getCacheTimeStamp() -> Date? {
        return UserDefaultsHelper.getCacheTimeStamp(for: .usersCacheTimeStamp)
    }
}

