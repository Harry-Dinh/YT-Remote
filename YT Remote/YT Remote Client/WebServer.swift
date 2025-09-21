//
//  WebServer.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Foundation
import Network

class WebServer {
    private var listener: NWListener?
    let port: UInt16

    init(port: UInt16 = 8080) {
        self.port = port
    }

    func start() throws {
        listener = try NWListener(using: .tcp, on: NWEndpoint.Port(rawValue: port)!)
        listener?.stateUpdateHandler = { newState in
            print("Server state: \(newState)")
        }
        listener?.newConnectionHandler = { [weak self] connection in
            self?.handle(connection: connection)
        }
        listener?.start(queue: .global(qos: .background))
        print("Server started on port \(port)")
    }

    func stop() {
        listener?.cancel()
        listener = nil
    }

    private func handle(connection: NWConnection) {
        connection.start(queue: .global(qos: .background))
        connection.receive(minimumIncompleteLength: 1, maximumLength: 8192) { data, _, _, _ in
            guard let data = data,
                  let request = String(data: data, encoding: .utf8) else {
                connection.cancel()
                return
            }

            print("Received request:\n\(request)")

            if let firstLine = request.components(separatedBy: "\r\n").first {
                if firstLine.contains("/signal/") {
                    let parts = firstLine.components(separatedBy: " ")
                    if parts.count > 1 {
                        let path = parts[1]
                        if let signalString = path.split(separator: "/").last,
                           let signal = KeySignal(rawValue: String(signalString).uppercased()) {
                            print("Triggering key press: \(signal)")
                            pressKey(for: signal)
                        }
                    }
                }
            }

            let responseBody = "Signal processed"
            let response =
            """
            HTTP/1.1 200 OK
            Content-Type: text/plain
            Content-Length: \(responseBody.utf8.count)
            
            \(responseBody)
            """

            connection.send(content: response.data(using: .utf8), completion: .contentProcessed { _ in
                connection.cancel()
            })
        }
    }
}
