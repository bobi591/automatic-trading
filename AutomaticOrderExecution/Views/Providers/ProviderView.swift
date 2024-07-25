//
//  ProviderView.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 22.07.24.
//

import Foundation
import SwiftUI

struct ProviderView: View {
    
    @StateObject var providerViewState: ProviderViewState = ProviderViewState()
    @State var positionsState: [AnyPosition] = []
    @State var errorState: ErrorState?
    
    let selectedProvider: ProviderType
    
    public init(providerType: ProviderType) {
        self.selectedProvider = providerType
    }
    
    var body: some View {
        if providerViewState.isBackPressed {
            ContentView()
        } else {
            VStack {
                HStack {
                    Button {
                        providerViewState.isBackPressed = true
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Switch provider")
                    }
                    .padding()
                    Spacer()
                }
                Text(selectedProvider.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                if !positionsState.isEmpty {
                    AllPositionsView(positions: positionsState)
                } else {
                    if let error = errorState?.error {
                        ProgressView()
                    }
                    else {
                        Text("Could not fetch data from " + selectedProvider.rawValue + " 😔")
                    }
                }
                Spacer()
            }
            .alert(item: $errorState) { errorState in
                Alert(title: Text("Provider error"), message: Text(errorState.error.localizedDescription), dismissButton: .cancel())
            }
            .onAppear {
                fetchAllPositions()
            }
        }
    }
    
    private func createPositionProvider() -> (any PositionProvider)? {
        switch selectedProvider {
        case .TRADING212:
            return Trading212PositionService()
        default:
            return nil
        }
    }
    
    private func fetchAllPositions() {
        createPositionProvider()?.allPositionsAsync(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let positions):
                    positionsState = positions
                case .failure(let error):
                    errorState = ErrorState(error: error)
                }
            }
        })
    }
}

#Preview {
    ProviderView(providerType: .TRADING212)
}

struct ErrorState: Identifiable {
    var id = UUID()
    var error: Error
}

class ProviderViewState: ObservableObject {
    @Published var isBackPressed = false
}

enum ProviderType: String {
    case TRADING212 = "Trading 212"
    case EMPTY = "EMPTY"
    case SETTINGS = "SETTINGS"
}
