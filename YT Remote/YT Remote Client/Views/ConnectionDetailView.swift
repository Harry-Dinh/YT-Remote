//
//  ConnectionDetailView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-19.
//

import SwiftUI

struct ConnectionDetailView: View {
    @Bindable var serverManager: ServerManager

    @Environment(\.dismiss) private var dismiss

    init(_ serverManager: ServerManager) {
        self.serverManager = serverManager
    }

    var body: some View {
        VStack {
            titleSection
            Form {
                rowView(title: "IP Address", content: WebServer.getComputerIPAddress() ?? "Unavailable")
                rowView(title: "Port", content: "\(serverManager.portNumber)")
            }
            .formStyle(.grouped)

            buttonsSection
        }
    }

    private var titleSection: some View {
        HStack {
            Text("Connection Details")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
        }
        .padding([.top, .horizontal])
    }

    private func rowView(title: String, content: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(content)
                .selectionDisabled(false)
                .fontDesign(.monospaced)
                .foregroundStyle(.secondary)
        }
    }

    private var buttonsSection: some View {
        HStack {
            Spacer()
            Button("Done", action: dismiss.callAsFunction)
                .keyboardShortcut(.cancelAction)
        }
        .padding()
    }
}

#Preview {
    ConnectionDetailView(ServerManager())
        .frame(maxWidth: 400)
}
