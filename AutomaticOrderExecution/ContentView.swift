//
//  ContentView.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 20.07.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewState: ContentViewState = ContentViewState()
    
    var body: some View {
        if(contentViewState.selectedProvider == .EMPTY) {
            VStack {
                Spacer(minLength: 50)
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer(minLength: 50)
                Text("Select provider")
                List {
                    Button {
                        contentViewState.selectedProvider = .TRADING212
                    } label: {
                        Text("Trading 212")
                    }
                }
                HStack {
                    Button {
                        contentViewState.selectedProvider = .SETTINGS
                    } label: {
                        HStack {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    }
                    .padding()
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
        }
        else if (contentViewState.selectedProvider == .SETTINGS) {
            SettingsView()
        }
        else {
            ProviderView(providerType: contentViewState.selectedProvider)
        }
    }
}

class ContentViewState: ObservableObject {
    @Published var selectedProvider: ProviderType = .EMPTY
}

#Preview {
    ContentView()
}
