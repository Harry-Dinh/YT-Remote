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
    
    @State private var showNameTextField = false

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                connectionInfoFields
                connectionNameSection
            }
            .navigationTitle("Manual Connection")
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
    
    private var connectionInfoFields: some View {
        Section {
            listRow(title: "IP Address") {
                TextField("XXX.YYY.Z.A", text: $viewModel.macIP)
                    .multilineTextAlignment(.trailing)
                    .fontDesign(.monospaced)
                    .keyboardType(.decimalPad)
                    .focused($isFieldFocused, equals: true)
            }

//                listRow(title: "Passcode") {
//                    TextField("XXYYZZ", text: $viewModel.passcode)
//                        .multilineTextAlignment(.trailing)
//                        .fontDesign(.monospaced)
//                        .keyboardType(.numberPad)
//                }

            listRow(title: "Port") {
                TextField("XXXX", text: $viewModel.customPortNumber)
                    .multilineTextAlignment(.trailing)
                    .fontDesign(.monospaced)
                    .keyboardType(.numberPad)
            }
        }
    }
    
    private var connectionNameSection: some View {
        Section {
            Toggle("Save Connection to Storage", isOn: $showNameTextField)
            
            if showNameTextField {
                TextField("Connection name", text: $viewModel.connectionName)
            }
        }
    }

    private var doneButton: some View {
        Group {
            if #available(iOS 26, *) {
                Button(role: .confirm, action: doneButtonAction) {
                    showNameTextField ?
                    Label("Save", systemImage: "square.and.arrow.down") :
                    Label("Done", systemImage: "checkmark")
                }
            } else {
                showNameTextField ?
                Button("Save", action: doneButtonAction) :
                Button("Done", action: doneButtonAction)
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
    
    // MARK: - Helper Functions and Properties
    
    private func doneButtonAction() {
        if showNameTextField && !viewModel.connectionName.isEmpty {
            let connection = YTRMConnection(
                ip: viewModel.macIP,
                port: viewModel.customPortNumber,
                passcode: "0000",   // Passcode is hardcoded for now while implementation is being worked on
                name: viewModel.connectionName
            )
            viewModel.connectionsList.append(connection)
            guard let listData = ConnectionCoder.shared.encode(viewModel.connectionsList) else {
                return
            }
            ConnectionCoder.shared.saveToStorage(connectionListData: listData)
        }
        dismiss()
    }
}

#Preview {
    IPEditScreen(MainViewModel())
}
