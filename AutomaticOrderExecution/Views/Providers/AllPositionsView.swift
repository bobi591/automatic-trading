//
//  AllPositionsView.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 23.07.24.
//

import Foundation
import SwiftUI
import DeckKit

struct AllPositionsView: View {
    @State var positions: [AnyPosition]

    var body: some View {
        DeckView($positions) { position in
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.orange)
                .overlay{
                    VStack {
                        Text("Stock Symbol: " + position.getSymbol())
                        Text("Average Price: " + getCurrencyFormatter().string(from: position.getAveragePrice() as NSNumber)!)
                        Text("Current Price: " + getCurrencyFormatter().string(from: position.getCurrentPrice() as NSNumber)!)
                    }
                }
                .shadow(radius: 10)
                .frame(width: 350, height: 400)
        }
    }
    
    private func getCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.currencyCode = "EUR"
        formatter.numberStyle = .currency
        return formatter
    }
}

#Preview {
    AllPositionsView(positions: [AnyPosition(position: Trading212Position(averagePrice: 100, currentPrice: 100, initialFillDate: "2024-07-19T17:45:01.000+03:00", quantity: 30, ppl: 12, fxPpl: 50, ticker: "AAPL")), AnyPosition(position: Trading212Position(averagePrice: 100, currentPrice: 100, initialFillDate: "2024-05-19T17:45:01.000+03:00", quantity: 30, ppl: 12, fxPpl: 50, ticker: "MSFT"))])
}
