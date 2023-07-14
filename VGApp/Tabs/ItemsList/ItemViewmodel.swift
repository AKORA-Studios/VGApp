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
    @Published var usedRecycleTypes: [RecycleTypes] = []
    @Published var recycleDict: [RecycleTypes: Int] = [:]
    
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
        print("called remove")
        
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
