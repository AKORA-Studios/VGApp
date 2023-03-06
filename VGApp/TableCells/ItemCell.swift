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
        HStack{
            IconManager().getIcon(item.name)
            Text(item.name)
            Spacer()
            Text(item.number)
                .foregroundColor(.gray)
        }
    }
}
