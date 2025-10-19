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
        Window(Text(Constants.appName), id: "mainwindow") {
            ContentView(serverManager)
        }
        .windowResizability(.contentSize)
        .commands {
            CommandMenu("Actions") {
                Button(serverManager.startListening ? "Stop Server" : "Start Server") {
                    serverManager.startListening.toggle()
                }
                .keyboardShortcut(.return)

                Button("Launch YouTube TV") {}
                    .keyboardShortcut("Y")
            }

            CommandGroup(replacing: .sidebar) {
                Button("Show Connection Detail") {
                    serverManager.showConnectionDetail = true
                }
                .disabled(!serverManager.startListening)
            }
        }
    }
}
