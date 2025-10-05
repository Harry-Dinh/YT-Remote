//
//  ContentView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-08-31.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = MainViewModel()
    @State private var showSettingsScreen = false

    private let navButtonSpacing: CGFloat = 20.0

    var body: some View {
        NavigationStack {
            VStack {
                navigationButtons
                    .disabled(viewModel.macIP.isEmpty)
            }
            .navigationTitle(viewModel.macIP.isEmpty ? "Not Connected" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    settingsButton
                }

                ToolbarItemGroup(placement: .bottomBar) {
                    volumeControlsSection
                }

                ToolbarItem(placement: .primaryAction) {
                    keyboardButton
                }
            }
            .safeAreaInset(edge: .bottom) {
                actionButtons
                    .disabled(viewModel.macIP.isEmpty)
            }
            .sheet(isPresented: $showSettingsScreen) {
                SettingsRootView(viewModel)
            }
            .alert(
                "Search YouTube Videos",
                isPresented: $viewModel.showKeyboardSearchAlert
            ) {
                TextField("Search", text: $viewModel.searchText)
                Button(role: .cancel, action: {
                    viewModel.searchText.removeAll()
                }) {
                    Text("Cancel")
                }

                Button(role: .none, action: {}) {
                    Text("Send to Mac")
                }
                .keyboardShortcut(.defaultAction)
                .disabled(viewModel.searchText.isEmpty)
            } message: {
                Text("Make sure you are on the YouTube search page before tapping the \"Send to Mac\" button.")
            }
        }
    }

    // MARK: - Subviews

    private var navigationButtons: some View {
        VStack(spacing: navButtonSpacing) {
            NavigationButton(.up) { sender.send(signal: NavigationButtonSignal.up) }
            navigationButtonsHorizontal
            NavigationButton(.down) { sender.send(signal: NavigationButtonSignal.down) }
        }
        .padding()
    }

    private var navigationButtonsHorizontal: some View {
        HStack(spacing: navButtonSpacing) {
            NavigationButton(.left) { sender.send(signal: NavigationButtonSignal.left) }
            NavigationButton(.return) { sender.send(signal: NavigationButtonSignal.return) }
            NavigationButton(.right) { sender.send(signal: NavigationButtonSignal.right) }
        }
    }

    private var settingsButton: some View {
        Button(action: {
            showSettingsScreen = true
        }) {
            Image(systemName: "gear")
        }
    }

    private var actionButtons: some View {
        HStack {
            ActionButton(.playPauseButton) { sender.send(signal: ActionButtonSignal.playPause) }
            Spacer()
            ActionButton(.backButton) { sender.send(signal: ActionButtonSignal.back) }
            Spacer()
            ActionButton(.contextMenuButton) {}
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private var volumeControlsSection: some View {
        if viewModel.showVolumeControls {
            if viewModel.volumeControlsPosition == .right {
                Group {
                    muteVolumeButton
                    Spacer()
                    volumeControls
                }
            } else {
                Group {
                    volumeControls
                    Spacer()
                    muteVolumeButton
                }
            }
        }
    }

    private var volumeControls: some View {
        Group {
            Button(action: {}) {
                Image(systemName: VolumeControlsButtonModel.volumeDown.rawValue)
            }

            Button(action: {}) {
                Image(systemName: VolumeControlsButtonModel.volumeUp.rawValue)
            }
        }
    }

    @ViewBuilder
    private var muteVolumeButton: some View {
        if viewModel.showVolumeControls {
            Button(action: {}) {
                Image(systemName: VolumeControlsButtonModel.mute.rawValue)
            }
        }
    }

    private var keyboardButton: some View {
        Button(action: {
            viewModel.showKeyboardSearchAlert = true
        }) {
            Image(systemName: "magnifyingglass")
        }
    }

    // MARK: - Helper Functions and Properties

    private var sender: SignalSender {
        SignalSender(macIP: viewModel.macIP)
    }
}

#Preview {
    ContentView()
}
