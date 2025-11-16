//
//  ConnectionsList.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-11-02.
//

import SwiftUI

struct ConnectionsList: View {
    @Bindable var viewModel: MainViewModel
    
    @State private var showQRCodeScanner = false
    @State private var showManualConnectionView = false
    
    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            Section("Previous Connections") {
                if viewModel.connectionsList.isEmpty {
                    connectionEmptyText
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.connectionsList) { connection in
                        connectionItemRow(connection)
                    }
                }
            }
        }
        .navigationTitle("Connect to Mac")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        .sheet(isPresented: $showQRCodeScanner) {
            QRCodeScannerView(viewModel)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showManualConnectionView) {
            IPEditScreen(viewModel)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                addConnectionMenuButton
                editButton
            }
        }
    }
    
    // MARK: - Subviews
    
    private func connectionItemRow(_ connection: YTRMConnection) -> some View {
        Label(connection.name, systemImage: "laptopcomputer")
    }
    
    private var addConnectionMenuButton: some View {
        Menu {
            Button(action: {
                showQRCodeScanner = true
            }) {
                Label("Scan Code", systemImage: "qrcode.viewfinder")
            }
            
            Button(action: {
                showManualConnectionView = true
            }) {
                Label("Connect Manually", systemImage: "app.connected.to.app.below.fill")
            }
        } label: {
            Label("Add New Connection", systemImage: "plus")
        }
    }
    
    private var editButton: some View {
        EditButton()
            .disabled(viewModel.connectionsList.isEmpty)
    }
    
    private var connectionEmptyText: some View {
        HStack {
            Spacer()
            Text("No Connections")
                .font(.title2)
                .foregroundStyle(.secondary)
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        ConnectionsList(MainViewModel())
    }
}
