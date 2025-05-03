//
//  ARMediaControl.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ARMediaControl: View {
    var body: some View {
        HStack(spacing: 20) {
            ARControlButton(icon: "backward", action: {})

            Button(action: {}) {
                ZStack {
                    Circle()
                        .foregroundStyle(Color(.systemGray3))
                        .frame(width: 130, height: 130)

                    Image(systemName: "playpause")
                        .font(.system(size: 45))
                        .foregroundStyle(.secondary)
                        .symbolVariant(.fill)
                }
            }
            .buttonStyle(.plain)

            ARControlButton(icon: "forward", action: {})
        }
    }
}

#Preview {
    ARMediaControl()
        .preferredColorScheme(.dark)
}
