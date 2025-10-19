//
//  String+Base64Decoded.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-19.
//

import Foundation

extension String {
    func base64Decoded(with encoding: Encoding = .utf8) -> String? {
        guard let stringData = Data(base64Encoded: self),
              let decodedString = String(data: stringData, encoding: encoding) else {
            return nil
        }
        return decodedString
    }
}
