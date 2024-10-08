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
    case editItem
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
    @Published var usedRecycleTypes: [RecycleTypes] = []
    @Published var recycleDict: [RecycleTypes: Int] = [:]
    @Published var recycleCount: Int = 1
    
    // edit Item
    @Published var toBeEditedItem: Item?
    @Published var toBeEditedItem_Name: String = ""
    @Published var toBeEditedItem_Number: String = "0000"
    
    @Published var showDeleteAlert = false
    
    func updateViews() {
        withAnimation {
            self.objectWillChange.send()
            list = Util.getSelectedList()
            items = Util.getItems()
            typeArr = RecycleTypes.allCases
            setUsedRecyleTypesArr()
        }
    }
    
    func setUsedRecyleTypesArr() {
        guard let list = list else { return }
        usedRecycleTypes = []
        let dict = CoreData.getRecylcesDict(list)
        
        RecycleTypes.allCases.forEach { type in
            if dict[type] != 0 { usedRecycleTypes.append(type) }
            recycleDict[type] = dict[type]
        }
    }
    
    func deleteItems() {
        guard let list = list else { return }
        
        Util.deleteAllItems(list)
        Util.save()
        updateViews()
    }
    
    func removeRecyle(for type: RecycleTypes) {
        guard let list = list else { return }
        CoreData.removeRecycle(list, type: type)
        Util.save()
        setUsedRecyleTypesArr()
    }
    
    func addRecyle(for type: RecycleTypes) {
        guard let list = list else { return }
        CoreData.addRecycle(list, type: type)
        Util.save()
        setUsedRecyleTypesArr()
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
    
    func showEditItemSheet(_ item: Item) {
        toBeEditedItem = item
        toBeEditedItem_Name = item.name
        toBeEditedItem_Number = item.number
        
        selectedSheetType = .editItem
        withAnimation { showsSheet = true }
    }
    
    func saveEditedItem() {
        guard let list = list else { return }
        guard let toBeEditedItem = toBeEditedItem else { return }
        
        // remove old one
        CoreData.removeItem(toBeEditedItem, list)
    
        // create new one
        Util.createItem(name: toBeEditedItem_Name, code: toBeEditedItem_Number)
        withAnimation { showsSheet = false }
        toBeEditedItem_Name = ""
        toBeEditedItem_Number = ""
        
        Util.save()
        updateViews()
    }
    
    func addRecyle(_ type: RecycleTypes) {
        guard let list = list else { return }
        for _ in 1...recycleCount {
            CoreData.addRecycle(list, type: type)
        }
        recycleCount = 1
        Util.save()
        withAnimation { showsSheet = false }
        setUsedRecyleTypesArr()
    }
    
    func createItem() {
        Util.createItem(name: newName, code: newNumber)
        updateViews()
        withAnimation { showsSheet = false }
        newName = ""
        newNumber = ""
    }
}
