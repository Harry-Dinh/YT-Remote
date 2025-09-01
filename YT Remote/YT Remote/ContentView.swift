//
//  ContentView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-08-31.
//

import SwiftUI

struct ContentView: View {
    @State private var tvCode = ""

    var body: some View {
        VStack(spacing: 20) {
            codeTextField
            navigationButtons
        }
        .padding()
    }

    private var codeTextField: some View {
        HStack {
            TextField("Enter TV Code here...", text: $tvCode)
                .textFieldStyle(.roundedBorder)

            Button("Connect") {}
        }
    }

    private var navigationButtons: some View {
        Group {
            Button("UP") {}
            Button("DOWN") {}
            Button("LEFT") {}
            Button("RIGHT") {}
            Button("SELECT") {}
        }
    }
}

#Preview {
    ContentView()
}
