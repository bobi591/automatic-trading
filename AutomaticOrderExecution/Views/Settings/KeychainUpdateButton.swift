//
//  KeychainUpdateButton.swift
//  AutomaticOrderExecution
//
//  Created by Boris Georgiev on 22.07.24.
//

import Foundation
import SwiftUI

struct KeychainUpdateButton: View {
    var label: String
    @State var keychainKey: String
    @State var keychainValue: String
    @State var isInputRequested: Bool = false
    
    init(label: String, keychainKey: String) {
        self.label = label
        self.keychainKey = keychainKey
        do {
            self.keychainValue = try KeychainUtils.retrieve(keychainKey) ?? ""
        }
        catch {
            self.keychainValue = ""
        }
    }
    
    var body: some View {
        Button {
            isInputRequested = true
        } label: {
            Text(label)
        }
        .alert(label, isPresented: $isInputRequested) {
            TextField("This value is not yet set", text: $keychainValue)
            Button("OK") {
                do {
                    try KeychainUtils.store(keychainValue, key: keychainKey)
                    keychainValue = try KeychainUtils.retrieve(keychainKey) ?? ""
                    isInputRequested = false
                }
                catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    KeychainUpdateButton(label: "My Keychain Property", keychainKey: "Test")
}

