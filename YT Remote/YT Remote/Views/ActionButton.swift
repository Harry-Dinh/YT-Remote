//
//  ActionButton.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct ActionButton: View {
    var icon: ActionButtonModel
    var action: () -> Void

    init(_ icon: ActionButtonModel, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    var body: some View {
        if #available(iOS 26, *) {
            Button(action: action) {
                buttonLabel
                    .glassEffect(.regular.interactive())
            }
        } else {
            Button(action: action) {
                buttonLabel
            }
        }
    }

    private var buttonLabel: some View {
        ZStack {
            Circle()
                .fill(Color(.systemGray3))
                .frame(width: 110, height: 110)

            Image(systemName: icon.rawValue)
                .symbolVariant(.fill)
                .font(.system(size: 50))
                .foregroundStyle(.white)
                .offset(y: iconYOffset)
        }
    }

    private var iconSize: CGFloat {
        icon == .contextMenuButton ? 30 : 50
    }

    private var iconYOffset: CGFloat {
        icon == .contextMenuButton ? 5 : 0
    }
}

#Preview {
    ContentView()
}
