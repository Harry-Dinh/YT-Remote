//
//  YTRemoteSender.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-06.
//

import Foundation
import Network

class YTRemoteSender: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    private let browser = NetServiceBrowser()
    private var service: NetService?
    private var connection: NWConnection?

    func start() {
        browser.delegate = self
        browser.searchForServices(ofType: "_ytremote._tcp", inDomain: "")
    }

    // Service found
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        self.service = service
        service.delegate = self
        service.resolve(withTimeout: 5.0)
    }

    // Service resolved, moving onto connect
    func netServiceDidResolveAddress(_ sender: NetService) {
//        guard let address = sender.addresses?.first else {
//            return
//        }

        let endpoint = NWEndpoint.hostPort(
            host: .name(sender.hostName ?? "", nil),
            port: NWEndpoint.Port(rawValue: UInt16(sender.port))!
        )
        connection = NWConnection(to: endpoint, using: .tcp)
        connection?.start(queue: .main)
    }

    func sendMessage(_ text: String) {
        guard let connection = connection else {
            return
        }

        let data = text.data(using: .utf8)
        connection.send(content: data, completion: .contentProcessed { error in
            if let error = error {
                print("Send error:", error)
            } else {
                print("Message \(text) was sent")
            }
        })
    }
}
