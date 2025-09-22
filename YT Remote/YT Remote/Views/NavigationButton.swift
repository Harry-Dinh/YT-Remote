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

    var body: some View {
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
