//
//  SignalSender.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Foundation

@Observable
class SignalSender {
    private var connection: YTRMConnection?

    func send(signal: String) {
        guard let connection = self.connection,
              let portInt = Int(connection.port),
              let url = URL(string: String(format: Constants.connectionURLScheme, connection.ip, portInt, signal)) else {
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
    
    func setCurrentConnection(with connection: YTRMConnection) {
        self.connection = connection
    }
}
