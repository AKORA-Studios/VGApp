//
//  TableCellStructs.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation
import UIKit

struct Section {
    let title: String
    let options: [ListSectionOption]
}

enum ListSectionOption{
    case listCell(model: ListOption)
}

struct ListOption{
    let title: String
    let subtitle: String
    let selectHandler: (() -> Void)
}
