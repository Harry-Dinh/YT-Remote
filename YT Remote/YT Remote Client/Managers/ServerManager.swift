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

    var portNumber = 8080
    var passcode = "000000"
    var qrCode: NSImage?
    var qrCodeGeneratingInProgress = false
    var startListening = false
    var showConnectionDetail = false

    func startServer() {
        do {
            let server = WebServer(port: UInt16(portNumber))
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

    func isServerActive() -> Bool {
        return server != nil
    }

    func createQRCode() async {
        await MainActor.run {
            qrCodeGeneratingInProgress = true
        }

        guard let ip = WebServer.getComputerIPAddress(),
              let qrCodeString = CodeGenerator.createEncodedStringFrom(ipAddress: ip, port: UInt16(portNumber), passcode: passcode) else {
            return
        }
        qrCode = CodeGenerator.generateCode(from: qrCodeString)

        await MainActor.run {
            qrCodeGeneratingInProgress = false
        }
    }

    func generatePasscode() -> String {
        let randomNumber = Int.random(in: 0...999_999)
        let generatedPasscode = String(format: "%06d", randomNumber)
        return generatedPasscode
    }
}
