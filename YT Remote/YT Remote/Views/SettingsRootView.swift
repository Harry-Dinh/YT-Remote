//
//  SettingsRootView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-22.
//

import SwiftUI

struct SettingsRootView: View {
    @Bindable var viewModel: MainViewModel

    @Environment(\.dismiss) private var dismiss

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    connectionHeader

                    NavigationLink(destination: QRCodeScannerView(viewModel)) {
                        Text("Connect to Mac")
                    }
                }

                Section {
                    disconnectButton
                    quitYouTubeButton
                }

                Section {
                    Toggle(isOn: $viewModel.showVolumeControls) {
                        Text("Show Volume Controls")
                    }

                    if viewModel.showVolumeControls {
                        Picker(selection: $viewModel.volumeControlsPosition) {
                            Text("Left").tag(VolumeControlsPosition.left)
                            Text("Right").tag(VolumeControlsPosition.right)
                        } label: {
                            Text("Volume Controls Position")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    doneButton
                }
            }
        }
    }

    private var doneButton: some View {
        Button(action: dismiss.callAsFunction) {
            Image(systemName: "checkmark")
        }
    }

    private var connectionHeader: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Connection Status")
                .font(.headline)

            HStack {
                Image(systemName: "circle.fill")
                    .imageScale(.small)
                    .foregroundStyle(isMacIPEmpty ? Color.red : Color.green)

                Text(isMacIPEmpty ? "Not Connected" : "Connected to Mac")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var disconnectButton: some View {
        Button(role: .destructive, action: {
            viewModel.showDisconnectConfirmation = true
        }) {
            Text("Disconnect from Mac")
        }
        .disabled(isMacIPEmpty)
        .confirmationDialog("Disconnect from Mac?", isPresented: $viewModel.showDisconnectConfirmation) {
            Button(role: .destructive) {
                viewModel.macIP.removeAll()
            } label: {
                Text("Disconnect")
            }

            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
        }
    }

    private var quitYouTubeButton: some View {
        Button(role: .destructive, action: {}) {
            Text("Exit YouTube TV")
        }
    }

    // MARK: - Helper Functions and Properties

    private var isMacIPEmpty: Bool {
        viewModel.macIP.isEmpty
    }
}

#Preview {
    SettingsRootView(MainViewModel())
}
