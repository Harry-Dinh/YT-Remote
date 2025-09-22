//
//  Signal Sender.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Foundation

class SignalSender {
    let macIP: String
    let port: Int

    init(macIP: String, port: Int = 8080) {
        self.macIP = macIP
        self.port = port
    }

    func send(signal: String) {
        guard let url = URL(string: "http://\(macIP):\(port)/signal/\(signal.uppercased())") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error sending signal: \(error)")
            } else {
                print("Sent signal: \(signal)")
            }
        }
        task.resume()
    }
}
