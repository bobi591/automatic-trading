//
//  Trading212PositionService.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import Foundation

public class Trading212PositionService: PositionProvider {
    private let _positionsUrl: String = "https://live.trading212.com/api/v0/equity/portfolio"
    
    public var positionsUrl: String {
        return _positionsUrl
    }

    public func allPositions() async throws -> [Trading212Position] {
        guard let apiKey = try KeychainUtils.retrieve(KeychainUtils.Keys.apiKeyTrading212) else {
            throw Trading212PositionServiceError.apiKeyNotFound
        }
        
        let headers: [String: String] = [
            "Authorization": apiKey
        ]

        do {
            let result: [Trading212Position] = try await RestUtils.get(urlString: positionsUrl, headers: headers)

            // Assuming Trading212Position conforms to Position protocol
            let positionsList: [Trading212Position] = result
            return positionsList

        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
            throw DecodingError.typeMismatch(type, context)
         }
        catch let DecodingError.valueNotFound(type, context)  {
            print("Type '\(type)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
            throw DecodingError.typeMismatch(type, context)
         }
    }

    public func specificPosition(ticker: String) async throws -> Trading212Position {
        throw fatalError("Not implemented!")
    }
}

enum Trading212PositionServiceError: Error {
    case apiKeyNotFound
    case retrievalFailed(String)
}
