//
//  Trading212Position.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import Foundation

public struct Trading212Position: Position {
    
    public var id = UUID()
    
    let averagePrice: Decimal
    let currentPrice: Decimal
    let initialFillDate: String
    let quantity: Decimal
    let ppl: Decimal
    let fxPpl: Decimal?
    let ticker: String
    
    private enum CodingKeys: String, CodingKey {
        case averagePrice, currentPrice, initialFillDate, quantity, ppl, fxPpl, ticker
    }

    public func getAveragePrice() -> Decimal {
        return averagePrice
    }

    public func getCurrentPrice() -> Decimal {
        return currentPrice
    }

    public func getFillDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: initialFillDate)!
    }

    public func getQuantity() -> Decimal {
        return quantity
    }

    public func getPl() -> Decimal {
        return ppl
    }

    public func getFxPl() -> Decimal {
        return fxPpl ?? 0
    }
    
    public func getSymbol() -> String {
        return ticker
    }
}
