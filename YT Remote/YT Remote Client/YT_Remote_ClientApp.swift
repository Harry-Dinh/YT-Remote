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
            ContentView()
                .onAppear(perform: serverManager.startServer)
                .onDisappear(perform: serverManager.stopServer)
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
