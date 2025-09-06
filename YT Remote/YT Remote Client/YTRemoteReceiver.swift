//
//  YTRemoteReceiver.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-06.
//

import Foundation
import Network

class YTRemoteReceiver {
    private var listener: NWListener?

    func start() {
        do {
            let params = NWParameters.tcp
            listener = try NWListener(using: params, on: 0)     // 0 is the auto port
            listener?.stateUpdateHandler = { state in
                print("Listener state:", state)
            }

            listener?.newConnectionHandler = { connection in
                connection.start(queue: .main)
                self.handleConnection(connection)
            }
            listener?.start(queue: .main)

            // Publish with Bonjour
            listener?.service = NWListener.Service(
                name: "MacService",
                type: "_ytremote._tcp",
                domain: nil,
                txtRecord: nil
            )
        } catch {
            print("Failed to start network listener.", error)
        }
    }

    private func handleConnection(_ connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 10) { data, _, isComplete, error in
            if let data = data, let message = String(data: data, encoding: .utf8) {
                print("Message received:", message)
            }

            if isComplete || error != nil {
                connection.cancel()
            }
        }
    }
}
