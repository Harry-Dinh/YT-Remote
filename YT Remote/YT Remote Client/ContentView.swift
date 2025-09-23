//
//  ContentView.swift
//  YT Remote Client
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct ContentView: View {
    @Bindable var serverManager: ServerManager

    @State private var confirmStoppingServer = false
    @State private var toggleServer = false

    init(_ serverManager: ServerManager) {
        self.serverManager = serverManager
    }

    var body: some View {
        VStack {
            Form {
                serverStatusSection
                ipSection
            }
            .formStyle(.grouped)

            Divider()
        }
        .onChange(of: toggleServer) {
            if toggleServer {
                serverManager.startServer()
            } else {
                confirmStoppingServer = true
            }
        }
        .alert("Confirm Stopping Server?", isPresented: $confirmStoppingServer) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                serverManager.stopServer()
                toggleServer = false
            }
        }
    }

    private var serverStatusSection: some View {
        Section {
            Toggle(isOn: $toggleServer) {
                HStack {
                    Image(systemName: "circle.fill")
                        .foregroundStyle(serverManager.isServerActive() ? Color.green : Color.red)
                    Text(serverManager.isServerActive() ? "Server is Running" : "Server is Inactive")
                }
            }
        } footer: {
            Button("Launch YouTube TV") {}
        }
    }

    private var ipSection: some View {
        Section {
            formRow(
                title: "Wi-Fi Address",
                info: WebServer.getComputerIPAddress() ?? "Unavailable",
                infoFontDesign: .monospaced
            )
        } header: {
            Text("Connection Information")
        } footer: {
            Button("Show Address...") {}
        }
    }

    // MARK: - Subviews

    private func formRow(title: String, info: String, infoFontDesign: Font.Design = .default) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(info)
                .foregroundStyle(.secondary)
                .fontDesign(infoFontDesign)
        }
    }
}

#Preview {
    ContentView(ServerManager())
}
