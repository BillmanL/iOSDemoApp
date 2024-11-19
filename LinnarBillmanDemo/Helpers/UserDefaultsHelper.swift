//
//  UserDefaultsHelper.swift
//  LinnarBillmanDemo
//
//  Created by Linnar Billman on 2024-11-18.
//

import Foundation

enum UserDefaultsKey: String {
    case movies = "LinnarDemoApp_Movies"
    case users = "LinnarDemoApp_Users"
    case moviesCacheTimeStamp = "LinnarDemoApp_Cache_Movies_Timestamp"
    case usersCacheTimeStamp = "LinnarDemoApp_Cache_Users_Timestamp"
    
    var keyString: String {
        if DemoAPI.shared.environment == .mock {
            return self.rawValue+"_Mock"
        } else {
            return self.rawValue
        }
    }
}

class UserDefaultsHelper {
    static func saveCacheTimeStamp(for key: UserDefaultsKey) {
        UserDefaults.standard.set(Date(), forKey: key.keyString)
    }
    
    static func getCacheTimeStamp(for key: UserDefaultsKey) -> Date? {
        guard let date = UserDefaults.standard.object(forKey: key.keyString) as? Date else {
            return nil
        }
        return date
    }
    
    static func getDecodableDataFromUserDefaults<T>(for key: UserDefaultsKey, model: T.Type) -> T? where T: Decodable {
        guard let data = UserDefaults.standard.data(forKey: key.keyString) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode(T.self, from: data)
            return movies
        } catch {
            return nil
        }
    }
    
    static func saveCodableDataToUserDefaults<T>(_ object: T, for key: UserDefaultsKey) where T: Encodable {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(object) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key.keyString)
    }
    
    static func clearDataFromUserDefaults(for key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.keyString)
    }
}
