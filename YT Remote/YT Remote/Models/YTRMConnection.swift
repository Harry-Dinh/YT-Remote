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

struct YTRMConnection: Equatable {
    var ip: String
    var port: String
    var passcode: String
}
