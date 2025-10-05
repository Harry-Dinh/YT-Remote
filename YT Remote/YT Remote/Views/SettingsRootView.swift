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
                    NavigationLink(destination: IPEditScreen(macIP: $viewModel.macIP)) {
                        Text("Edit IP Address")
                    }
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
}

#Preview {
    SettingsRootView(MainViewModel())
}
