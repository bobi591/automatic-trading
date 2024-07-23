//
//  AnyPosition.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 23.07.24.
//

import Foundation

public struct AnyPosition: Position {
    public var id: UUID
    public var symbol: String
    public var averagePrice: Decimal
    public var currentPrice: Decimal
    public var fillDate: Date
    public var quantity: Decimal
    public var pl: Decimal
    public var fxPl: Decimal
    
    public init(position: any Position) {
        id = UUID()
        symbol = position.getSymbol()
        averagePrice = position.getAveragePrice()
        currentPrice = position.getCurrentPrice()
        fillDate = position.getFillDate()
        quantity = position.getQuantity()
        pl = position.getPl()
        fxPl = position.getFxPl()
    }
    
    public func getId() -> UUID {
        return id
    }
    
    public func getAveragePrice() -> Decimal {
        return averagePrice
    }
    
    public func getCurrentPrice() -> Decimal {
        return currentPrice
    }
    
    public func getFillDate() -> Date {
        return fillDate
    }
    
    public func getQuantity() -> Decimal {
        return quantity
    }
    
    public func getPl() -> Decimal {
        return pl
    }
    
    public func getFxPl() -> Decimal {
        return fxPl
    }
    
    public func getSymbol() -> String {
        return symbol
    }
    
}
