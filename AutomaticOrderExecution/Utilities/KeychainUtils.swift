//
//  KeychainUtils.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 21.07.24.
//

import Foundation
import KeychainAccess

public class KeychainUtils {
    private static let keychainAccess: Keychain = Keychain(service: "com.bgeorgiev.AutomaticOrderExecution")
    private init () {
        
    }
    
    public static func store(_ value: String, key: String) throws {
        try keychainAccess.set(value, key: key)
    }
    
    public static func retrieve(_ key: String) throws -> String? {
        return try keychainAccess.get(key)
    }
    
    public static func removeAll() throws {
        try keychainAccess.removeAll();
    }
    
    public struct Keys {
        static let apiKeyTrading212 = "TRADING212_API_KEY"
    }
}
