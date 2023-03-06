//
//  ScannerScreen.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI


struct UIViewScanner: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScannerView
    @State var scannedCode: String?
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = ScannerView()

        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
