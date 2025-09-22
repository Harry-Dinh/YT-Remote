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
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    settingsButton
                }
            }
            .safeAreaInset(edge: .bottom) {
                actionButtons
                    .disabled(viewModel.isMacIPEmpty)
            }
            .sheet(isPresented: $showSettingsScreen) {
                SettingsRootView(viewModel)
            }
        }
    }

    // MARK: - Subviews

    private var navigationButtons: some View {
        VStack(spacing: navButtonSpacing) {
            NavigationButton(.up) { sender.send(signal: "UP") }
            navigationButtonsHorizontal
            NavigationButton(.down) { sender.send(signal: "DOWN") }
        }
        .padding()
    }

    private var navigationButtonsHorizontal: some View {
        HStack(spacing: navButtonSpacing) {
            NavigationButton(.left) { sender.send(signal: "LEFT") }
            NavigationButton(.return) { sender.send(signal: "RETURN") }
            NavigationButton(.right) { sender.send(signal: "RIGHT") }
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
            ActionButton(.backButton) { sender.send(signal: "ESCAPE") }
            Spacer()
            ActionButton(.playPauseButton) { sender.send(signal: "F8") }
            Spacer()
            ActionButton(.contextMenuButton) {}
        }
        .padding(.horizontal)
    }

    // MARK: - Helper Functions and Properties

    private var sender: SignalSender {
        SignalSender(macIP: viewModel.macIP)
    }
}

#Preview {
    ContentView()
}
