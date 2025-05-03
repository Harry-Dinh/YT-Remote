//
//  ARNavButton.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ARNavButton: View {

    var type: ARNavButtonType
    var action: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .frame(width: 80, height: 80)
                .foregroundStyle(Color(.systemGray3))

            Button(action: action) {
                if type == .navUp {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 45))
                } else if type == .navDown {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 45))
                } else if type == .navLeft {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 45))
                } else if type == .navRight {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 45))
                } else {
                    Image(systemName: "square")
                        .font(.system(size: 45))
                }
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ARNavButton(type: .navSelect, action: {})
        .preferredColorScheme(.dark)
}
