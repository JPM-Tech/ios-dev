//
//  DataScannerRepresentable.swift
//  QR-Code-Tutorial
//
//  Created by Chase on 2/10/23.
//

import SwiftUI
import VisionKit

struct DataScannerRepresentable: UIViewControllerRepresentable {
    @Binding var shouldStartScanning: Bool
    @Binding var scannedText: String
    var dataToScanFor: Set<DataScannerViewController.RecognizedDataType>
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
       var parent: DataScannerRepresentable
       
       init(_ parent: DataScannerRepresentable) {
           self.parent = parent
       }
               
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
            case .barcode(let barcode):
                parent.scannedText = barcode.payloadStringValue ?? "Unable to decode the scanned code"
            default:
                print("unexpected item")
            }
        }
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        // Create the data scanner, present it, and start scanning!
        let dataScannerVC = DataScannerViewController(
            recognizedDataTypes: dataToScanFor,
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        dataScannerVC.delegate = context.coordinator
       
       return dataScannerVC
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
       if shouldStartScanning {
           try? uiViewController.startScanning()
       } else {
           uiViewController.stopScanning()
       }
    }

    func makeCoordinator() -> Coordinator {
       Coordinator(self)
    }
}
