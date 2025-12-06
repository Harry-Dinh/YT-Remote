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
            Section("Saved Connections") {
                if viewModel.connectionsList.isEmpty {
                    connectionEmptyText
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(viewModel.connectionsList) { connection in
                        ConnectionListRowView(connection: connection) {
                            viewModel.connectToDevice(with: connection)
                        }
                    }
                }
            }
        }
        .navigationTitle("Connect to Mac")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: .constant(""),
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .refreshable {
            Task { await viewModel.getConnectionList() }
        }
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
            if #available(iOS 26, *) {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
            }
            
            ToolbarItemGroup(placement: .primaryAction) {
                editButton
            }
            
            if #available(iOS 26, *) {
                ToolbarSpacer(.flexible, placement: .bottomBar)
            } else {
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                addConnectionMenuButton
            }
        }
    }
    
    // MARK: - Subviews
    
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
