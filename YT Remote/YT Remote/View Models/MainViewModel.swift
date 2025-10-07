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
    var showVolumeControls = true
    var volumeControlsPosition: VolumeControlsPosition = .right
    var macIP = ""
    var showKeyboardSearchAlert = false
    var searchText = ""
    var showDisconnectConfirmation = false
}
