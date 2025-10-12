//
//  KeySignal.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Cocoa
import Foundation
import CoreGraphics

enum KeySignal: String {
    case up = "UP"
    case down = "DOWN"
    case left = "LEFT"
    case right = "RIGHT"
    case `return` = "RETURN"
    case escape = "ESCAPE"
    case f8 = "F8"
    case f10 = "F10"
    case f11 = "F11"
    case f12 = "F12"
}

func pressKey(for signal: KeySignal) {
    switch signal {
        case .up: sendKey(keyCode: 0x7E)
        case .down: sendKey(keyCode: 0x7D)
        case .left: sendKey(keyCode: 0x7B)
        case .right: sendKey(keyCode: 0x7C)
        case .escape: sendKey(keyCode: 0x35)
        case .return: sendKey(keyCode: 0x24)
        case .f8: sendKey(keyCode: 0x31)    // 0x31 = Spacebar for playpause
        case .f10: sendKey(keyCode: 0x6D)
        case .f11: sendKey(keyCode: 0x6B)
        case .f12: sendKey(keyCode: 0x6F)
    }
}

private func sendKey(keyCode: CGKeyCode) {
    if let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true),
       let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false) {
        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }
}
