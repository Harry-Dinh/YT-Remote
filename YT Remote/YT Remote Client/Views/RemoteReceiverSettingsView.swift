//
//  RemoteReceiverSettingsView.swift
//  Remote Receiver
//
//  Created by Harry Dinh on 2025-11-23.
//

import SwiftUI

struct RemoteReceiverSettingsView: View {
    @Bindable var viewModel: SettingsViewModel
    
    init(_ viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Toggle(isOn: $viewModel.shouldAuthenticateForConnectionDetails) {
                if viewModel.deviceSupportBiometrics() {
                    Text("Use Touch ID to show connection details")
                } else {
                    Text("Use login password to show connection details")
                }
            }
            .onChange(of: viewModel.shouldAuthenticateForConnectionDetails) { _, newValue in
                viewModel.userDefaults.set(
                    newValue,
                    forKey: viewModel.useBiometricsForConnectionInfoUDKey
                )
            }
        }
        .formStyle(.columns)
        .padding()
    }
}

#Preview {
    RemoteReceiverSettingsView(SettingsViewModel())
}
