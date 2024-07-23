//
//  Position.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import Foundation
import DeckKit

public protocol Position: Codable, Equatable, DeckItem {
    func getAveragePrice() -> Decimal
    func getCurrentPrice() -> Decimal
    func getFillDate() -> Date
    func getQuantity() -> Decimal
    func getPl() -> Decimal
    func getFxPl() -> Decimal
    func getSymbol() -> String
}
