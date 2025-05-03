//
//  ContentView.swift
//  AirRemote
//
//  Created by Harry Dinh on 2025-05-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Button(action: {}) {
                    Label("Settings", systemImage: "gear")
                }
                .buttonStyle(.bordered)
                Text("Currently controlling: MacBook Pro")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            ARMediaControl()

            HStack() {
                ARControlButton(icon: "airplay.audio", action: {})
                Spacer()
                ARControlButton(icon: "speaker.slash", action: {})
                Spacer()
                ARVolumeControl()
            }
            .padding(.horizontal)
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
