//
//  SettingsViewModel.swift
//  Remote Receiver
//
//  Created by Harry Dinh on 2025-11-23.
//

import Observation
import SwiftUI
import LocalAuthentication

@Observable
class SettingsViewModel {
    var shouldAuthenticateForConnectionDetails = false
    let userDefaults = UserDefaults.standard
    private var laContextError: NSError?
    
    private let laContext = LAContext()
    let useBiometricsForConnectionInfoUDKey = "USE_BIOMETRICS_FOR_CONNECTION_INFO"
    
    func deviceSupportBiometrics() -> Bool {
        return laContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &laContextError)
    }
    
    func fetchSavedSettings() {
        // Use biometrics for showing connection info
        shouldAuthenticateForConnectionDetails = userDefaults.bool(forKey: useBiometricsForConnectionInfoUDKey)
    }
}
