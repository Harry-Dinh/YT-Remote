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

    // MARK: - Helper Functions and Properties

    static func getComputerIPAddress() -> String? {
        var address: String?

        var ifaddrPointer: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddrPointer) == 0 else { return nil }
        guard let firstAddress = ifaddrPointer else { return nil }

        for ptr in sequence(first: firstAddress, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee

            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) {
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    let saLen = socklen_t(interface.ifa_addr.pointee.sa_len)
                    getnameinfo(
                        interface.ifa_addr,
                        saLen,
                        &hostname,
                        socklen_t(hostname.count),
                        nil,
                        socklen_t(0),
                        NI_NUMERICHOST
                    )
                    address = String(cString: hostname)
                    break
                }
            }
        }

        freeifaddrs(ifaddrPointer)
        return address
    }
}
