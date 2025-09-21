//
//  ServerManager.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI
import Observation

@Observable
class ServerManager {
    private var server: WebServer?

    func startServer() {
        do {
            let server = WebServer(port: 8080)
            try server.start()
            self.server = server
        } catch {
            print("Failed to start server: \(error)")
        }
    }

    func stopServer() {
        server?.stop()
        server = nil
    }
}
