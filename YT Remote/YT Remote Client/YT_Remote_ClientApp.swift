//
//  YT_Remote_ClientApp.swift
//  YT Remote Client
//
//  Created by Harry Dinh on 2025-09-06.
//

import SwiftUI

@main
struct YT_Remote_ClientApp: App {
    let remoteReceiver = YTRemoteReceiver()

    init() {
        remoteReceiver.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
