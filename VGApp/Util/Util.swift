//
//  Util.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation

let context = CoreDataStack.shared.managedObjectContext

enum RecycleTypes: String, CaseIterable {
    case yoghurtglass = "1"
    case bottle = "2"
    case crate = "3"
}

struct Util {
    /// Saves the current CoreData context.
    static func save() {
        try! context.save()
    }
    
    /// Returns the current CoreData
    /// - Returns: AppData
    static func getAppData() -> AppData {
        return CoreData.getCoreData()!
    }
    
    /// Fetches Lists from CoreData
    /// - Returns: all ShopingLists
    static func getLists() -> [ShoppingList] {
        return CoreData.getAlllLists()
    }
    
    /// Filters all ShoppingLists for the active one.
    /// - Returns: current active ShopingLists
    static func getSelectedList() -> ShoppingList {
        guard let list = getAppData().selected else {
            setSelectedList()
            return getAppData().selected!
        }
        return list
    }
    
    /// Set a new active ShoppingList
    ///
    /// - Parameters:
    ///     - list: The list you want to activate
    static func setSelectedList(_ list: ShoppingList = createNewList()) {
        getAppData().selected = list
        save()
    }
    
    /// Creates a new empty ShoppingList
    /// - Returns: new ShoopingList
    static func createNewList() -> ShoppingList {
        let newList = ShoppingList(context: context)
        
        newList.date = Date()
        newList.items = []
        
        CoreData.addList(newList)
        save()
        return newList
    }
    
    /// Fetches a lists items  for the given `list`.
    ///
    /// - Parameters:
    ///     - list: The list to fetch items from
    ///
    /// - Returns: Items of the `list`
    static func getItems(_ list: ShoppingList = getSelectedList()) -> [Item] {
        return CoreData.getListItems(list)
    }
    
    /// Delete all ShoppingLists from CoreData
    static func deleteAllLists() {
        let appData = getAppData()
        appData.selected = nil
        appData.lists = []
        save()
    }
    
    /// Delete all Items & recycleItems from a ShoppingLists
    ///
    /// - Parameters:
    ///     - list: The list to delete items from
    static func deleteAllItems(_ list: ShoppingList) {
        list.items = []
        list.listToRecycle = []
        save()
    }
    
    /// Create a new Item for the given `list`.
    ///
    /// - Parameters:
    ///     - list: The list to add the item to
    ///     - name: The items name
    ///     - code: The items code
    static func createItem(_ list: ShoppingList = getSelectedList(), name: String, code: String) {
        var codeArr = code.map {String($0)}
        
        for _ in 1...4 {
            if codeArr.count < 4 {
                codeArr.append("0")
            }
        }
        
        let newItem = Item(context: context)
        newItem.name = name
        newItem.number = codeArr.joined(separator: "")
        newItem.icon = "apple"
        list.addToItems(newItem)
        
        // add to history
        CoreData.addHistory(newItem)
        
        save()
    }
    
    /// Get the Name for the given `type` as String.
    ///
    /// - Parameters:
    ///     - type: a RecycleType
    ///
    /// - Returns: the String Representation for the given `type`.
    static func recTypeName(_ type: RecycleTypes) -> String {
        switch type {
        case .yoghurtglass:
            return "recycleType_glas".localized
        case .bottle:
            return "recycleType_bottle".localized
        case .crate:
            return "recycleType_crate".localized
        }
    }
    
}
