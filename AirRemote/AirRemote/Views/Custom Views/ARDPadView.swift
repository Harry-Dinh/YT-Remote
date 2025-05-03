//
//  ARDPadView.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ARDPadView: View {
    var body: some View {
        VStack(spacing: 25) {
            ARNavButton(type: .navUp, action: {})
            HStack(spacing: 25) {
                ARNavButton(type: .navLeft, action: {})
                ARNavButton(type: .navSelect, action: {})
                ARNavButton(type: .navRight, action: {})
            }
            ARNavButton(type: .navDown, action: {})
        }
    }
}

#Preview {
    ARDPadView()
        .padding()
        .preferredColorScheme(.dark)
}
