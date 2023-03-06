//
//  IconManager.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

struct IconManager {
    
    let icons: [String: Image] = [
        "carrot": Image(systemName: "carrot")
    ]
    
    let names: [String: [String]] = [
        "carrot": ["möhre", "karotte"]]
    
    func getIcon(_ str: String) -> Image?{
        var img: Image? = nil
        
        names.forEach { entry in
            if(entry.value.contains(str.lowercased())){
                print(entry.value)
                img =  icons[entry.key]
            }
        }
        return img
    }
}
