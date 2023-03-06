//
//  ScannerScreen.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI


struct ScannerScreen: UIViewControllerRepresentable {
    typealias UIViewControllerType = ScannerView
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = ScannerView()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }

}
