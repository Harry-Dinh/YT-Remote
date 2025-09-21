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
        WindowGroup {
            ContentView()
                .onAppear(perform: serverManager.startServer)
                .onDisappear(perform: serverManager.stopServer)
        }
    }
}
