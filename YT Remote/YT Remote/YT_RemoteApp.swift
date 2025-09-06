//
//  YT_RemoteApp.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-08-31.
//

import SwiftUI

@main
struct YT_RemoteApp: App {
    let remoteSender = YTRemoteSender()

    init() {
        remoteSender.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
