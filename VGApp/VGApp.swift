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
                UIViewScanner()
                    .tabItem {
                        Image(systemName: "barcode.viewfinder")
                    }
                Itemview(vm: ItemViewmodel())
                    .tabItem {
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                    }
                ListView(vm: ListViewmodel())
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                    }
            }
        }
    }
}
