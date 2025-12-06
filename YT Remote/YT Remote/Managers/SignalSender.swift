//
//  SignalSender.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Foundation

class SignalSender {
    var connection: YTRMConnection?

    init(connection: YTRMConnection?) {
        self.connection = connection
    }

    func send(signal: String) {
        guard let connection = self.connection,
              let url = URL(string: String(format: Constants.connectionURLScheme, connection.ip, connection.port, signal)) else {
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
