//
//  IPEditScreen.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct IPEditScreen: View {
    @Binding var macIP: String

    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFieldFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                TextField("IP Address", text: $macIP)
                    .fontDesign(.monospaced)
                    .keyboardType(.decimalPad)
                    .focused($isFieldFocused, equals: true)
            }
            .navigationTitle("Edit IP Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    doneButton
                }
            }
            .onAppear {
                isFieldFocused = true
            }
        }
    }

    private var doneButton: some View {
        Group {
            if #available(iOS 26, *) {
                Button(action: dismiss.callAsFunction) {
                    Image(systemName: "checkmark")
                }
                .buttonStyle(.glassProminent)
            } else {
                Button("Done", action: dismiss.callAsFunction)
            }
        }
        .disabled(macIP.isEmpty)
    }
}

#Preview {
    IPEditScreen(macIP: .constant(""))
}
