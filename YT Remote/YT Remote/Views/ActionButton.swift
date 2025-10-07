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

    @State private var buttonPressed = false

    var body: some View {
        Group {
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
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !buttonPressed {
                        buttonPressed = true
                        let haptic = UIImpactFeedbackGenerator(style: isBackButton ? .medium : .light)
                        haptic.impactOccurred()
                    }
                }
                .onEnded { _ in
                    if buttonPressed {
                        let haptic = UIImpactFeedbackGenerator(style: isBackButton ? .heavy : .medium)
                        haptic.impactOccurred()
                    }
                    buttonPressed = false
                }
        )
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

    private var isBackButton: Bool {
        icon == .backButton
    }
}

#Preview {
    ContentView()
}
