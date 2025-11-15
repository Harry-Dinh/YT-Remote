//
//  QRCodeScannerView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-11-02.
//

import SwiftUI
import CodeScanner

struct QRCodeScannerView: View {
    @Bindable var viewModel: MainViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            CodeScannerView(codeTypes: [.qr], scanMode: .once, completion: handleCodeDetected)
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        cancelButton
                    }
                }
        }
    }
    
    private var cancelButton: some View {
        Button(action: dismiss.callAsFunction) {
            Label("Cancel", systemImage: "xmark")
        }
    }
    
    // MARK: - Helper Functions and Properties
    
    private func handleCodeDetected(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let scanResult):
            print("Scan succeeded:\n\(scanResult.string)")
        case .failure(let error):
            print("Scan error occurred: \(error.localizedDescription)")
        }
    }
}

#Preview {
    QRCodeScannerView(MainViewModel())
}
