//
//  ARVolumeControl.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ARVolumeControl: View {
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: 80, height: 200)
                .foregroundStyle(Color(.systemGray3))

            VStack {
                Button(action: {}) {
                    Image(systemName: "speaker.plus")
                        .font(.system(size: 35))
                        .foregroundStyle(.secondary)
                }
                .offset(x: 0, y: -47)

                Button(action: {}) {
                    Image(systemName: "speaker.minus")
                        .font(.system(size: 35))
                        .foregroundStyle(.secondary)
                }
                .offset(x: 0, y: 47)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ARVolumeControl()
        .preferredColorScheme(.dark)
}
