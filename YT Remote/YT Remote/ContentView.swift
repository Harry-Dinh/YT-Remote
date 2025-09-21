//
//  ContentView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-08-31.
//

import SwiftUI

struct ContentView: View {
    @State private var macIP: String = ""
    private var sender: SignalSender {
        SignalSender(macIP: macIP)
    }

    var body: some View {
        NavigationStack {
            VStack {
                navigationButtons
                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    ipAddressButton
                }
            }
            .safeAreaInset(edge: .bottom) {
                actionButtons
            }
        }
    }

    private var navigationButtons: some View {
        VStack(spacing: 20) {
            NavigationButton("chevron.up") { sender.send(signal: "UP") }
            navigationButtonsHorizontal
            NavigationButton("chevron.down") { sender.send(signal: "DOWN") }
        }
    }

    private var navigationButtonsHorizontal: some View {
        HStack(spacing: 20) {
            NavigationButton("chevron.left") { sender.send(signal: "LEFT") }
            NavigationButton("square") { sender.send(signal: "RETURN") }
            NavigationButton("chevron.right") { sender.send(signal: "RIGHT") }
        }
    }

    private var ipAddressButton: some View {
        Button(action: {}) {
            Image(systemName: "ellipsis.rectangle")
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
}

#Preview {
    ContentView()
}
