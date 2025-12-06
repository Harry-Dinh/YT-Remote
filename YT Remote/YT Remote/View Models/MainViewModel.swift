//
//  MainViewModel.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-22.
//

import SwiftUI
import Observation

@Observable
class MainViewModel {
    // Settings
    var showVolumeControls = false
    var volumeControlsPosition: VolumeControlsPosition = .right
    var showManualConnectionScreen = false
    var showDisconnectConfirmation = false
    var macIP = ""
//    var passcode = ""
    var customPortNumber = ""
    var connectionName = ""
    
    // Home
    var showKeyboardSearchAlert = false
    var searchText = ""
    
    // View models
    var currentConnection: YTRMConnection?
    var connectionsList: [YTRMConnection] = []
    
    func getConnectionList() async {
        if !connectionsList.isEmpty {
            await MainActor.run {
                self.connectionsList.removeAll()
            }
        }
        
        guard let connectionListData = ConnectionCoder.shared.getListData(),
              let connectionsList = await ConnectionCoder.shared.decode(listData: connectionListData) else {
            return
        }
        
        await MainActor.run {
            self.connectionsList = connectionsList
        }
    }
    
    func connectToDevice(with connection: YTRMConnection) {
        currentConnection = connection
        macIP = connection.ip
        customPortNumber = connection.port
    }
}
