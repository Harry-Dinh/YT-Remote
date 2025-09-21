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
}

func pressKey(for signal: KeySignal) {
    let keyCode: CGKeyCode
    switch signal {
        case .up: keyCode = 0x7E
        case .down: keyCode = 0x7D
        case .left: keyCode = 0x7B
        case .right: keyCode = 0x7C
    }

    if let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: true),
       let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: keyCode, keyDown: false) {
        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }
}
