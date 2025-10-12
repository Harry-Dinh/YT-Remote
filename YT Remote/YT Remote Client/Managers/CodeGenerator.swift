//
//  CodeGenerator.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-12.
//

import Cocoa
import CoreImage

class CodeGenerator {
    static func createEncodedStringFrom(ipAddress: String, port: UInt16, passcode: String) -> String? {
        guard let encodedIP = ipAddress.data(using: .utf8),
              let encodedPort = String(port).data(using: .utf8),
              let encodedPasscode = passcode.data(using: .utf8) else {
            return nil
        }

        let mergedString = String(
            format: Constants.qrCodeFormat,
            encodedIP.base64EncodedString(),
            encodedPort.base64EncodedString(),
            encodedPasscode.base64EncodedString()
        )
        return mergedString
    }

    static func generateCode(from string: String) -> NSImage? {
        guard let data = string.data(using: .utf8),
              let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }

        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("M", forKey: "inputCorrectionLevel")

        guard let ciImage = filter.outputImage else {
            return nil
        }

        let rep = NSCIImageRep(ciImage: ciImage)
        let nsImage = NSImage(size: rep.size)
        nsImage.addRepresentation(rep)
        return nsImage
    }
}
