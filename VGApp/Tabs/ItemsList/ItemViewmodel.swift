//
//  ItemViewmodel.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

enum SHEETTYPE {
    case newItem
    case newRecycle
}

class ItemViewmodel: ObservableObject {
    @Published var list: ShoppingList?
    @Published var items: [Item] = []

    @Published var showsSheet = false
    @Published var selectedSheetType = SHEETTYPE.newItem

    // new Item
    @Published var newName = ""
    @Published var newNumber = ""

    // new recycle
    @Published var newRecycleType = 0
    @Published var typeArr: [RecycleTypes] = []

    func updateViews() {
        withAnimation {
            self.objectWillChange.send()
            list = Util.getSelectedList()
            items = Util.getItems()
        }
        typeArr = RecycleTypes.allCases
    }

    func deleteItems() {
        guard let list = list else {
            return
        }
        Util.deleteAllItems(list)
        Util.save()
        updateViews()
    }

    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = items[i]
            CoreData.removeItem(theItem, list!)
            Util.save()
        }
        updateViews()
    }

    func showNewRecycleSheet() {
        selectedSheetType = .newRecycle
        withAnimation { showsSheet = true }
    }

    func showNewItemSheet() {
        selectedSheetType = .newItem
        withAnimation { showsSheet = true }
    }

    func addRecyle() {
        let newRecyle = typeArr[newRecycleType]
        CoreData.addRecycle(list!, type: newRecyle)
        Util.save()
        withAnimation { showsSheet = false }
    }

    func createItem() {
        Util.createItem(name: newName, code: newNumber)
        updateViews()
        withAnimation { showsSheet = false }
        newName = ""
        newNumber = ""
    }
}
