//
//  ItemCell.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

struct ItemCell: View {
    let item: Item
    
    var body: some View {
        HStack {
            if IconManager.hasIcon(item.name) {
                IconManager.getIcon(item.name)!
                    .resizable()
                    .frame(width: 25, height: 25)
                    .colorMultiply(.gray)
            }
         
            Text(item.name)
            Spacer()
            Text(item.number)
                .foregroundColor(.gray)
        }
    }
}
