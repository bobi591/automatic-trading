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
                        Spacer()
                        Text(position.getSymbol())
                            .bold()
                            .font(.title)
                            .padding()
                        Spacer()
                        VStack {
                            Text("Fill date: " + getDateFormatter().string(from: (position.getFillDate() as NSDate) as Date))
                                .padding()
                            VStack {
                                Text("Average Price: " + getCurrencyFormatter().string(from: position.getAveragePrice() as NSNumber)!)
                                Text("Current Price: " + getCurrencyFormatter().string(from: position.getCurrentPrice() as NSNumber)!)
                                Text("Quantity: " + getNumberFormatter().string(from: position.getQuantity() as NSNumber)!)
                                Text("P&L: " + getCurrencyFormatter().string(from: position.getPl() as NSNumber)!)
                                Text("FX P&L: " + getCurrencyFormatter().string(from: position.getFxPl() as NSNumber)!)
                            }
                        }
                        .padding()
                        Spacer()
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
    
    private func getNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter
    }
    
    private func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }
}

#Preview {
    AllPositionsView(positions: [AnyPosition(position: Trading212Position(averagePrice: 100, currentPrice: 100, initialFillDate: "2024-07-19T17:45:01.000+03:00", quantity: 30, ppl: 12.3, fxPpl: -1.25, ticker: "AAPL")), AnyPosition(position: Trading212Position(averagePrice: 100, currentPrice: 100, initialFillDate: "2024-05-19T19:32:05.000+03:00", quantity: 30, ppl: 12, fxPpl: 50, ticker: "MSFT"))])
}
