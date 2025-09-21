//
//  NavigationButton.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct NavigationButton: View {
    var icon: String
    var action: () -> Void

    init(_ icon: String, action: @escaping () -> Void) {
        self.icon = icon
        self.action = action
    }

    var body: some View {
        if #available(iOS 26, *) {
            //            Button(action: action) {
            //                Image(systemName: icon)
            //                    .font(.system(size: 80))
            //                    .padding()
            //            }
            //            .buttonStyle(.glass)
            //            .buttonBorderShape(.roundedRectangle(radius: 15))

            Button(action: action) {
                buttonLabel
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

            Image(systemName: icon)
                .font(.system(size: 80))
                .fontWeight(.medium)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    NavigationButton("chevron.up") {}
}
