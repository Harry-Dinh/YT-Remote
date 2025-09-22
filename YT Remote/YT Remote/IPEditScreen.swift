//
//  IPEditScreen.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct IPEditScreen: View {
    @Binding var macIP: String
    @Environment(\.dismiss) private var dismissAction

    var body: some View {
        NavigationStack {
            Form {
                TextField("IP Address", text: $macIP)
                    .fontDesign(.monospaced)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Edit IP Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: dismissAction.callAsFunction) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    IPEditScreen(macIP: .constant(""))
}
