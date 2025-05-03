//
//  ARControlButton.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ARControlButton: View {

    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .frame(width: 85, height: 85)
                    .foregroundStyle(Color(.systemGray3))

                if icon == "speaker.slash" {
                    Image(systemName: icon)
                        .font(.system(size: 45))
                        .offset(x: 0, y: 2)
                        .foregroundStyle(.secondary)
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 45))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ARControlButton(icon: "speaker.slash", action: {})
}
