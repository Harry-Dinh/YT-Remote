//
//  YTRMConnection.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-19.
//

enum YTRMDeepLinkComponent {
    case ip
    case port
    case passcode
}

import Foundation

struct YTRMConnection: Equatable, Codable, Identifiable {
    var id: String
    var ip: String
    var port: String
    var passcode: String
    var name: String
    
    init(
        id: String = UUID().uuidString,
        ip: String,
        port: String,
        passcode: String,
        name: String = "Unnamed Connection"
    ) {
        self.id = id
        self.ip = ip
        self.port = port
        self.passcode = passcode
        self.name = name
    }
}
