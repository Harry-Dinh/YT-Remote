//
//  YT_Remote_ClientApp.swift
//  YT Remote Client
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

@main
struct YT_Remote_ClientApp: App {
    @State private var serverManager = ServerManager()

    var body: some Scene {
        Window("YT Remote Client", id: "clientApp") {
            ContentView(serverManager)
                .onDisappear {
                    // Quit the app upon closing the window
                    NSApplication.shared.terminate(nil)
                }
        }
        .windowToolbarStyle(.unified)
        .windowToolbarLabelStyle(fixed: .titleAndIcon)
        .commands {
            CommandMenu("Actions") {
                Button("Launch YouTube TV") {}
                    .keyboardShortcut(.return)
                Button("Stop Server") {}
                    .keyboardShortcut(".")
            }
        }
    }
}
