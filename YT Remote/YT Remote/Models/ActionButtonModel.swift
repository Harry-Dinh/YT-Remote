//
//  ActionButtonModel.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

enum ActionButtonModel: String {
    case backButton = "arrow.left"
    case playPauseButton = "playpause"
    case contextMenuButton = "filemenu.and.cursorarrow"
}

enum ActionButtonSignal {
    static let back = "ESCAPE"
    static let playPause = "F8"
    static let contextMenu = "CONTEXT"
}
