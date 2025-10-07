//
//  NavigationButton.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct NavigationButton: View {
    var buttonModel: NavigationButtonModel
    var action: () -> Void

    init(_ buttonModel: NavigationButtonModel, action: @escaping () -> Void) {
        self.buttonModel = buttonModel
        self.action = action
    }

    @State private var buttonPressed = false

    var body: some View {
        Group {
            if #available(iOS 26, *) {
                Button(action: action) {
                    buttonLabel
                        .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 20))
                }
            } else {
                Button(action: action) {
                    buttonLabel
                }
            }
        }
        .simultaneousGesture(
            // Handle the haptic behaviour
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !buttonPressed {
                        buttonPressed = true
                        let lightGenerator = UIImpactFeedbackGenerator(style: .light)
                        lightGenerator.impactOccurred()
                    }
                }
                .onEnded { _ in
                    if buttonPressed {
                        let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
                        mediumGenerator.impactOccurred()
                    }
                    buttonPressed = false
                }
        )
    }

    private var buttonLabel: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray3))
                .frame(width: 120, height: 120)

            Image(systemName: buttonModel.rawValue)
                .font(.system(size: 80))
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationButton(.up) {}
}
