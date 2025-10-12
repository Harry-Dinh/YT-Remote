//
//  QRCodeScannerView.swift
//  YT Remote
//
//  Created by Harry Dinh on 2025-10-12.
//

import SwiftUI
import CodeScanner
import AVFoundation

struct QRCodeScannerView: View {
    @Bindable var viewModel: MainViewModel

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if #available(iOS 26, *) {
            mainContent
                .scrollEdgeEffectStyle(.soft, for: .bottom)
        } else {
            mainContent
        }
    }

    private var mainContent: some View {
        GeometryReader { proxy in
            VStack {
                codeScannerView(proxy)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    viewModel.showManualConnectionScreen = true
                }) {
                    Text("Connect Manually")
                }
            }
        }
        .sheet(isPresented: $viewModel.showManualConnectionScreen) {
            IPEditScreen(viewModel)
        }
    }

    private func codeScannerView(_ proxy: GeometryProxy) -> some View {
        Group {
#if targetEnvironment(simulator)
            simulatorPlaceholderView(proxy)
#else
            if isCameraPermission(.authorized) {
                qrCodeScanner
            } else if isCameraPermission(.notDetermined) {
                codeScannerUnavailableView(proxy)
            }
#endif
        }
    }

#if targetEnvironment(simulator)
    private func simulatorPlaceholderView(_ proxy: GeometryProxy) -> some View {
        Rectangle()
            .fill(Color.black)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: proxy.size.height / 2)
            .overlay {
                Text("Code Scanner Unavailable (Simulator)")
                    .foregroundStyle(.white)
            }
    }
#else
    private func codeScannerUnavailableView(_ proxy: GeometryProxy) -> some View {
        Text("Permission not Granted")
    }

    private var qrCodeScanner: some View {
        CodeScannerView(codeTypes: [.qr], scanMode: .once) { result in

        }
    }
#endif

    // MARK: - Helpers

    private func isCameraPermission(_ status: AVAuthorizationStatus) -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == status
    }
}

#Preview {
    QRCodeScannerView(MainViewModel())
}
