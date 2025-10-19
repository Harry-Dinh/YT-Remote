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

    @Environment(\.dismiss) private var dismiss
    @State private var showConnectionSuccessfulAlert = false
    @State private var showConnectionFailureAlert = false
    @State private var showLoadingIndicator = false

    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                codeScannerView(proxy)
                viewfinderOverlayView
            }
        }
        .sheet(isPresented: $viewModel.showManualConnectionScreen) {
            IPEditScreen(viewModel)
        }
        .alert("Connection Successful!", isPresented: $showConnectionSuccessfulAlert) {
            Button("Continue", action: dismiss.callAsFunction)
        }
        .alert("Connection Failure", isPresented: $showConnectionFailureAlert) {
            Button("Try Again") {}
            Button("Connect Manually") {
                viewModel.showManualConnectionScreen = true
            }
        } message: {
            Text("Unable to connect, please try scanning again manually enter the connection information.")
        }

    }

    private func codeScannerView(_ proxy: GeometryProxy) -> some View {
        Group {
#if targetEnvironment(simulator)
            simulatorPlaceholderView(proxy)
#else
            if isCameraPermission(.authorized) {
                CodeScannerView(codeTypes: [.qr], scanMode: .once, completion: handleScannerCallback)
            } else if isCameraPermission(.notDetermined) {
                codeScannerUnavailableView(proxy)
            }
#endif
        }
        .ignoresSafeArea()
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
#endif

    private var manualConnectionButton: some View {
        Button(action: {
            viewModel.showManualConnectionScreen = true
        }) {
            Text("Connect Manually")
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.capsule)
        }
    }

    private var viewfinderOverlayView: some View {
        VStack {
            Spacer()
            manualConnectionButton
        }
        .padding(.bottom)
    }

    // MARK: - Helpers

    private func isCameraPermission(_ status: AVAuthorizationStatus) -> Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == status
    }

    private func handleScannerCallback(with result: Result<ScanResult, ScanError>) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

        Task {
            await toggleLoadingIndicator(true)
            switch result {
                case .success(let scanResult):
                    print("Success case")
                    guard let connection = DecodingManager.shared.decodeQRCodeData(with: scanResult.string) else {
                        await toggleLoadingIndicator(false)
                        return
                    }
                    viewModel.currentConnection = connection

                    guard let ip = connection.ip.base64Decoded(),
                          let port = connection.port.base64Decoded(),
                          let passcode = connection.passcode.base64Decoded() else {
                        await toggleLoadingIndicator(false)
                        return
                    }

                    await MainActor.run {
                        viewModel.macIP = ip
                        viewModel.customPortNumber = port
                        viewModel.passcode = passcode
                        showLoadingIndicator = false
                        showConnectionSuccessfulAlert = true
                    }
                case .failure(let error):
                    print("Failure case")
                    await MainActor.run { showConnectionFailureAlert = true }
                    print("Scan error occurred: \(error.localizedDescription)")
            }

            await toggleLoadingIndicator(false)
        }
    }

    private func toggleLoadingIndicator(_ isShown: Bool) async {
        await MainActor.run { showLoadingIndicator = isShown }
    }
}

#Preview {
    QRCodeScannerView(MainViewModel())
}
