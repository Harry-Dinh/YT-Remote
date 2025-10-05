//
//  VolumeControlsPosition.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-22.
//

enum VolumeControlsPosition: Hashable {
    case left, right
}

enum VolumeControlsButtonModel: String, CaseIterable {
    case volumeDown = "speaker.minus"
    case volumeUp = "speaker.plus"
    case mute = "speaker.slash"
}

enum VolumeControlsSignal {
    static let volumeDown = "VOL_DOWN"
    static let volumeUp = "VOL_UP"
    static let mute = "VOL_MUTE"
}
