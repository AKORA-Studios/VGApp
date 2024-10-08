//
//  IconManager.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

let icons: [String: Image] = [
    "carrot": Image("carrot"),
    "apple": Image("apple"),
    "avocado": Image("avocado"),
    "banana": Image("banana"),
    "brocolli": Image("brocolli"),
    "pepper": Image("pepper"),
    "pepper_sharp": Image("pepper 1"),
    "cherry": Image("cherry"),
    "lemon": Image("lemon"),
    "grapes": Image("grapes"),
    "orange": Image("orange"),
    "pear": Image("pear"),
    "strawberry": Image("strawberry"),
    "tomato": Image("tomato"),
    
    // recycle
    "glass": Image("glass"),
    "yogurt": Image("yogurt"),
    "crate": Image("crate")
]

let names: [String: [String]] = [
    "carrot": ["möhre", "möhren", "karotte", "karotten"],
    "apple": ["apfel", "äpfel"],
    "avocado": ["avokado", "avokados", "avocado"],
    "banana": ["banane", "bananen"],
    "brocolli": ["brokkoli"],
    "cherry": ["kirsche", "kirschen"],
    "lemon": ["zitrone", "zitronen"],
    "grapes": ["trauben", "weintrauben"],
    "orange": ["orange", "orangen"],
    "pepper_sharp": ["paprikasspitz", "paprikaspitz"],
    "pepper": ["paprika", "paprikas"],
   
    "pear": ["birne", "birnen"],
    "strawberry": ["erdbeere", "erdbeeren"],
    "tomato": ["tomate", "tomaten"],
    
    "glass": ["glass"],
    "yogurt": ["yogurt"],
    "crate": ["crate"]
]

struct IconManager {
    static func getIcon(_ str: String) -> Image {
        var img = Image(systemName: "questionmark.diamond")
     
        names.forEach { entry in
            entry.value.forEach { val in
                if str.lowercased().replacingOccurrences(of: " ", with: "").contains(val) {
                    guard let icon = icons[entry.key] else { return }
                    img = icon
                }
            }
        }
        return img
    }
    
    static func hasIcon(_ str: String) -> Bool {
        var value: Bool = false
        
        names.forEach { entry in
            entry.value.forEach { val in
                if str.lowercased().replacingOccurrences(of: " ", with: "").contains(val) {
                    value = true
                }
            }
        }
        return value
    }
    
    static func recycleIcon(_ type: RecycleTypes) -> Image? {
        switch type {
        case .yoghurtglass:
            return getIcon("yogurt")
        case .bottle:
            return getIcon("glass")
        case .crate:
            return getIcon("crate")
        }
    }
    
    static func get_recycle_image(_ type: RecycleTypes) -> Image {
        var img: Image?
        
        switch type {
        case .yoghurtglass:
            img = icons["yogurt"]
        case .bottle:
            img = icons["glass"]
        case .crate:
            img = icons["crate"]
        }
        
        guard let img = img else {
            return Image(systemName: "questionmark.diamond")
        }
        return img
    }
}
