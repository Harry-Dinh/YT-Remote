//
//  NavigationButtonModel.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-22.
//

enum NavigationButtonModel: String {
    case up = "chevron.up"
    case down = "chevron.down"
    case left = "chevron.left"
    case right = "chevron.right"
    case `return` = "square"
}

func signalFor(buttonModel: NavigationButtonModel) -> String {
    switch buttonModel {
        case .up:
            return "UP"
        case .down:
            return "DOWN"
        case .left:
            return "LEFT"
        case .right:
            return "RIGHT"
        case .return:
            return "RETURN"
    }
}
