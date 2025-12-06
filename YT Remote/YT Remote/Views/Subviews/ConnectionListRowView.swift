//
//  ConnectionListRowView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-12-06.
//

import SwiftUI

struct ConnectionListRowView: View {
    let connection: YTRMConnection
    var tapAction: () -> Void
    
    var body: some View {
        HStack {
            Text(connection.name)
            Spacer()
            Button(action: {}) {
                Image(systemName: "info")
                    .symbolVariant(.circle)
                    .imageScale(.large)
            }
        }
        .onTapGesture(perform: tapAction)
    }
}

#Preview {
    ConnectionListRowView(connection: YTRMConnection.previewPlaceholder) {}
        .padding()
}
