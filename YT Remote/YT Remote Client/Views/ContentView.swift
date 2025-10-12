//
//  ContentView.swift
//  YT Remote Client
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct ContentView: View {
    @Bindable var serverManager: ServerManager

    init(_ serverManager: ServerManager) {
        self.serverManager = serverManager
    }

    // MARK: - Main View Components

    var body: some View {
        Form {
            connectionStatusSection
            qrCodeSection
            extraActionsSection
        }
        .formStyle(.grouped)
        .frame(width: 400, height: 450)
    }

    private var connectionStatusSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 0) {
                serverStatusTitle
                serverStatusSubtitle
            }
        }
    }

    @ViewBuilder
    private var qrCodeSection: some View {
        if serverManager.startListening {
            Section {
                if serverManager.qrCodeGeneratingInProgress {
                    ProgressView("Generating QR Code...")
                        .progressViewStyle(.linear)
                } else {
                    qrCodeView
                }
            } header: {
                Text("Connection Guide")
            } footer: {
                connectionGuideFooter
                    .disabled(serverManager.qrCodeGeneratingInProgress)
            }
        }
    }

    @ViewBuilder
    private var extraActionsSection: some View {
        if serverManager.startListening {
            Section("Other Actions") {
                rowView(title: "YouTube TV") {
                    Button("Launch") {}
                }
            }
        }
    }

    // MARK: - Subviews

    private var serverStatusTitle: some View {
        Toggle(isOn: $serverManager.startListening) {
            Text("Server Status")
                .font(.headline)
        }
        .controlSize(.large)
        .onChange(of: serverManager.startListening) {
            if serverManager.startListening {
                serverManager.startServer()
                serverManager.passcode = serverManager.generatePasscode()
                Task {
                    await serverManager.createQRCode()
                }
            } else {
                serverManager.stopServer()
                serverManager.qrCode = nil
            }
        }
    }

    private var serverStatusSubtitle: some View {
        HStack(alignment: .center) {
            Image(systemName: "circle.fill")
                .imageScale(.small)
                .foregroundStyle(isServerActive ? Color.green : Color.red)
            Text(isServerActive ? "Online" : "Offline")
        }
    }

    private var connectionGuideFooter: some View {
        Group {
            Button("Manual Connection") {}
        }
    }

    private func rowView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
            Spacer()
            content()
        }
    }

    private var qrCodeView: some View {
        HStack {
            Spacer()
            if let nsImage = serverManager.qrCode {
                Image(nsImage: nsImage)
                    .interpolation(.none)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
            } else {
                VStack {
                    Image(systemName: "xmark.square")
                        .font(.title)
                        .foregroundStyle(.red)
                    Text("Failed to generate QR code. Turn the server off and on again to generate again.")
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
        }
    }

    // MARK: - Helper Functions and Properties

    private var isServerActive: Bool {
        serverManager.isServerActive() && serverManager.startListening
    }
}

#Preview {
    ContentView(ServerManager())
}
