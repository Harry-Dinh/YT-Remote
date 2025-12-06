//
//  String+Base64Decoded.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-19.
//

import Foundation

extension String {
    /// Encode a string to Base64 with UTF8 encoding by default, or can specify specific encoding method.
    /// - Parameter encoding: Encoding method, UTF8 by default if not specified
    /// - Returns: Optional Base64-encoded string
    func base64Decoded(with encoding: Encoding = .utf8) -> String? {
        guard let stringData = Data(base64Encoded: self),
              let decodedString = String(data: stringData, encoding: encoding) else {
            return nil
        }
        return decodedString
    }
}
