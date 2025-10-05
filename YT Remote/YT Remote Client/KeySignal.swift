//
//  KeySignal.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import Cocoa

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
    let keyCode: CGKeyCode
    switch signal {
        case .up: keyCode = 0x7E
        case .down: keyCode = 0x7D
        case .left: keyCode = 0x7B
        case .right: keyCode = 0x7C
        case .return: keyCode = 0x24
        case .escape: keyCode = 0x35
        case .f8: keyCode = 0x64
        case .f10: keyCode = 0x6D
        case .f11: keyCode = 0x6B
        case .f12: keyCode = 0x6F
    }

    if let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true),
       let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false) {
        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }
}
