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
    
    // MARK: - Main Views

    var body: some View {
        NavigationStack {
            Form {
                statusSection
                connectSection
                volumeControlSection
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
    
    private var statusSection: some View {
        Section {
            connectionHeader
            if !viewModel.macIP.isEmpty {
                disconnectButton
            }
        }
    }
    
    private var connectSection: some View {
        Section {
            savedConnectionsButton
        }
    }
    
    private var volumeControlSection: some View {
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
    
    // MARK: - Subviews

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
    
    private var savedConnectionsButton: some View {
        NavigationLink(destination: ConnectionsList(viewModel)) {
            Text("Connect to Mac")
        }
    }

    private var disconnectButton: some View {
        Button(role: .destructive, action: {
            viewModel.showDisconnectConfirmation = true
        }) {
            Text("Disconnect")
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
