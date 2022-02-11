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
    case deleteCell(model: DeleteOption)
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
    case deleteCell(model: DeleteOption)
}

struct ItemOption{
    let title: String
    let subtitle: String
    let item: Item
    let selectHandler: (() -> Void)
}


struct Section3 {
    let title: String
    var options: [DeleteSectionOption]
}

enum DeleteSectionOption{
    case deleteCell(model: DeleteOption)
}

struct DeleteOption{
    let selectHandler: (() -> Void)
}
