//
//  IconManager.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

let icons: [String: Image] = [
    "carrot": Image(systemName: "carrot"),
    "apple": Image("apple"),
    "avocado": Image("avocado"),
    "banana": Image("banana"),
    "brocolli": Image("brocolli"),
    "cherry": Image("cherry"),
    "citrus": Image("citrus"),
    "grapes": Image("grapes"),
    "orange": Image("orange"),
    "pear": Image("pear"),
    "strawberry": Image("strawberry"),
    "tomato": Image("tomato"),
]

let names: [String: [String]] = [
    "carrot": ["möhre","möhren", "karotte", "karotten"],
    "apple": ["apfel", "äpfel"],
    "avocado": ["avokado", "avokados", "avocado"],
    "banana": ["banane", "bananen"],
    "brocolli": ["brokkoli"],
    "cherry": ["kirsche", "kirschen"],
    "citrus": ["zitrone", "zitronen"],
    "grapes": ["trauben", "weintrauben"],
    "orange": ["orange", "orangen"],
    "pear": ["birne", "birnen"],
    "strawberry": ["erdbeere", "erdbeeren"],
    "tomato": ["tomate", "tomaten"],
]

struct IconManager {
    static func getIcon(_ str: String) -> Image?{
        var img: Image? = nil
     
        names.forEach { entry in
            entry.value.forEach { val in
                if(val == str.lowercased()){
                    img = icons[entry.key]
                }
            }
        }
        return img
    }
    
    static func hasIcon(_ str: String) -> Bool{
        var value: Bool = false
        
        names.forEach { entry in
            entry.value.forEach { val in
                if(val == str.lowercased()){
                    value = true
                }
            }
        }
        return value
    }
}
