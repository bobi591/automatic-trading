//
//  SettingsView.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 22.07.24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State var nextView : AnyView?
    @State var requireUpdateKeychain = false
    @State var selectedKeychainValue = ""
    
    var body: some View {
        if let nextView = nextView {
            nextView
        }
        else {
            VStack {
                HStack {
                    Button {
                        nextView = AnyView(ContentView())
                    } label: {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .padding()
                    Spacer()
                }
                Text("Settings")
                Spacer()
                KeychainUpdateButton(label: "Trading 212 API Key", keychainKey: KeychainUtils.Keys.apiKeyTrading212)
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
