//
//  TableCellStructs.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation
import UIKit
import CoreData

struct Section {
    let title: String
    var options: [ListSectionOption]
}

enum ListSectionOption{
    case listCell(model: ListOption)
}

struct ListOption{
    let title: String
    let subtitle: String
    let list: ShoppingList
    let selectHandler: (() -> Void)
}


struct Section2 {
    let title: String
    var options: [ItemSectionOption]
}

enum ItemSectionOption{
    case itemCell(model: ItemOption)
}

struct ItemOption{
    let title: String
    let subtitle: String
    let item: Item
    let selectHandler: (() -> Void)
}

