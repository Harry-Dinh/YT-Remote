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

enum NavigationButtonSignal {
    static let up = "UP"
    static let down = "DOWN"
    static let left = "LEFT"
    static let right = "RIGHT"
    static let `return` = "RETURN"
}
