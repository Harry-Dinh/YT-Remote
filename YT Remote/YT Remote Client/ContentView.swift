//
//  ContentView.swift
//  YT Remote Client
//
//  Created by Harry Dinh on 2025-09-21.
//

import SwiftUI

struct ContentView: View {
    private let instructionsText =
    """
    1. Get the IP address of this computer, you can do so with the command below in a terminal session
    2. Enter the IP address into the YT Remote app on your iPhone or iPad
    3. Enjoy!
    """

    var body: some View {
        HStack {
            sidebarView

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                Text("Instructions")
                    .font(.title3)
                    .fontWeight(.bold)
                ipAddressSection
            }
        }
        .padding()
    }

    private var ipAddressSection: some View {
        Group {
            Text(instructionsText)
                .padding(.horizontal)
            terminalCommandBox
        }
    }

    private var terminalCommandBox: some View {
        GroupBox {
            Text("ipconfig getifaddr en0")
                .fontDesign(.monospaced)
        }
        .padding()
    }

    private var stopServerButton: some View {
        Button(action: {}) {
            Text("Stop Server")
        }
    }

    private var openYouTubeTVButton: some View {
        Button(action: {}) {
            Text("Launch YouTube TV")
        }
    }

    private var sidebarView: some View {
        VStack {
            Text("YT Remote Client")
                .font(.title)
                .fontWeight(.bold)

            openYouTubeTVButton
            stopServerButton
        }
    }
}

#Preview {
    ContentView()
}
