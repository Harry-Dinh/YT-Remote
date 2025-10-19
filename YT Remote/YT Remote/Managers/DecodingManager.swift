//
//  DecodingManager.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-19.
//

import Observation

@Observable
class DecodingManager {
    static let shared = DecodingManager()

    private let ipParamStartIndex = 7

    func decodeQRCodeData(with qrString: String) -> YTRMConnection? {
        // Separate the string components
        guard let encodedIP = getEncodedDeepLinkComponent(.ip, from: qrString),
              let encodedPort = getEncodedDeepLinkComponent(.port, from: qrString),
              let encodedPasscode = getEncodedDeepLinkComponent(.passcode, from: qrString) else {
            return nil
        }
        return YTRMConnection(ip: encodedIP, port: encodedPort, passcode: encodedPasscode)
    }

    func isValidQRString(_ qrString: String) -> Bool {
        return qrString.contains("ytrm://")
    }

    private func getEncodedDeepLinkComponent(_ component: YTRMDeepLinkComponent, from qrString: String) -> String? {
        switch component {
            case .ip:
                guard let startIndex = qrString.index(qrString.startIndex, offsetBy: ipParamStartIndex, limitedBy: qrString.endIndex),
                      let endIndex = qrString[startIndex...].firstIndex(of: "&") else {
                    return nil
                }
                let encodedIP = String(qrString[startIndex..<endIndex])
                return encodedIP
            case .port:
                guard let portParamStartIndex = qrString.firstIndex(of: "="),
                      let endIndex = qrString[portParamStartIndex...].firstIndex(of: "&") else {
                    return nil
                }
                let encodedPort = String(qrString[portParamStartIndex..<endIndex])
                return encodedPort
            case .passcode:
                guard let range = qrString.range(of: "pa=") else {
                    return nil
                }
                let encodedPasscode = String(qrString[range.upperBound...])
                return encodedPasscode
        }
    }
}
