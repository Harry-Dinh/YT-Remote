//
//  IPEditScreen.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct IPEditScreen: View {
    @Bindable var viewModel: MainViewModel

    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFieldFocused: Bool

    @AppStorage("defaultPortPreference") private var useCustomPort = false

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                firstSection
                secondSection
            }
            .navigationTitle("Connect Manually")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDismissesKeyboard(.interactively)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }

                ToolbarItem(placement: .confirmationAction) {
                    doneButton
                }
            }
        }
    }

    private var firstSection: some View {
        Section {
            listRow(title: "IP Address") {
                TextField("XXX.YYY.Z.A", text: $viewModel.macIP)
                    .multilineTextAlignment(.trailing)
                    .fontDesign(.monospaced)
                    .keyboardType(.decimalPad)
                    .focused($isFieldFocused, equals: true)
            }

            listRow(title: "Passcode") {
                TextField("XXYYZZ", text: $viewModel.passcode)
                    .multilineTextAlignment(.trailing)
                    .fontDesign(.monospaced)
                    .keyboardType(.numberPad)
            }
        }
    }

    private var secondSection: some View {
        Section {
            Toggle(isOn: $useCustomPort) {
                Text("Use Custom Port")
            }

            if useCustomPort {
                listRow(title: "Custom Port Number") {
                    TextField("XXXX", text: $viewModel.customPortNumber)
                        .multilineTextAlignment(.trailing)
                        .fontDesign(.monospaced)
                        .keyboardType(.numberPad)
                }
            }

        } header: {
            Text("Port")
        } footer: {
            Text("Leave this off to use the default port of 8080.")
        }
    }

    private var doneButton: some View {
        Group {
            if #available(iOS 26, *) {
                Button(role: .confirm, action: dismiss.callAsFunction) {
                    Label("Done", systemImage: "checkmark")
                }
            } else {
                Button("Done", action: dismiss.callAsFunction)
            }
        }
        .disabled(viewModel.macIP.isEmpty)
    }

    private var cancelButton: some View {
        Button(role: .cancel, action: dismiss.callAsFunction) {
            Label("Cancel", systemImage: "xmark")
        }
    }

    private func listRow<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
            Spacer()
            content()
        }
    }
}

#Preview {
    IPEditScreen(MainViewModel())
}
