//
//  ConnectionEncoder.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-11-15.
//

import Observation
import Foundation

@Observable
class ConnectionCoder {
    static let shared = ConnectionCoder()
    
    func encode(_ connectionsList: [YTRMConnection]) -> Data? {
        return try? JSONEncoder().encode(connectionsList)
    }
    
    func saveToStorage(connectionListData: Data) {
        UserDefaults.standard.set(connectionListData, forKey: "connectionListDataKey")
    }
}
