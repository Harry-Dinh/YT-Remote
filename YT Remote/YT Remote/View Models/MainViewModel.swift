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
    var showVolumeControls = true
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
}
