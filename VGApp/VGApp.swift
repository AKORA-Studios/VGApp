//
//  VGApp.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

@main
struct VGApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ScannerScreen()
                    .tabItem {
                        Image(systemName: "barcode.viewfinder")
                    }
                Itemview()
                    .tabItem {
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                    }
                ListView()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                    }
            }
        }
    }
}
