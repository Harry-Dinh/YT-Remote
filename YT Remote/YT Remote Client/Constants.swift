//
//  Constants.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-12.
//

import Foundation

class Constants {
    static let qrCodeFormat: String = "ytrm://%@&po=%@&pa=%@"
    static let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
}
