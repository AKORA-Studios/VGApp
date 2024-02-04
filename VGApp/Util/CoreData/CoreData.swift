//
//  CoreData.swift
//  openWB App
//
//  Created by Kiara on 08.02.22.
//

import Foundation

struct CoreData {

    /// Returns basic App CoreData
    static func getCoreData() -> AppData? {
        var items: [AppData]
        do {
            items = try context.fetch(AppData.fetchRequest())
            
            if items.isEmpty {
                let item = AppData(context: context)
                try! context.save()
                return item
            }
            return items[0]
        } catch {}
        return nil
    }
    
    /// Returns an array of all Lists
    static func getAlllLists() -> [ShoppingList] {
        guard let data = getCoreData()!.lists else {
            return []
        }
        
        guard let lists = data.allObjects as! [ShoppingList]? else {
            return []
        }
        
        return lists.sorted(by: {$0.date > $1.date})
    }
    
    /// addt item to specific shoppinglist
    static func addItem(_ item: Item, _ list: ShoppingList) {
        let allLists = getAlllLists()
        if allLists.isEmpty { return }
        
        let data = (getAlllLists().filter {$0.objectID == list.objectID})[0]
        data.addToItems(item)
        try! context.save()
    }
    
    /// remove item form specific shoppinglist
    static func removeItem(_ item: Item, _ list: ShoppingList) {
        let allLists = getAlllLists()
        if allLists.isEmpty { return }
        
        let data = (getAlllLists().filter {$0.objectID == list.objectID})[0]
        data.removeFromItems(item)
        try! context.save()
    }
    
    /// create list
    static func addList(_ list: ShoppingList) {
        let data = getCoreData()!
        data.addToLists(list)
        try! context.save()
    }
    
    /// delete list
    static func removeList(_ list: ShoppingList) {
        let data = getCoreData()
        data?.removeFromLists(list)
        if data?.selected == list {
            data?.selected = nil
        }
        Util.save()
    }
    
    /// Get all items of a list
    static func getListItems(_ list: ShoppingList) -> [Item] {
        guard let items = list.items else {
            return []
        }
        if items.allObjects.isEmpty { return []}
        
        return (items.allObjects as! [Item]).sorted(by: {$0.name.lowercased() < $1.name.lowercased()})
    }
    
    static func addRecycle(_ list: ShoppingList, type: RecycleTypes) {
        let newRecycle = RecycleItem(context: context)
        newRecycle.recType = type.rawValue
        list.addToListToRecycle(newRecycle)
    }
    
    static func removeRecycle(_ list: ShoppingList, type: RecycleTypes) {
        let items = getRecylces(list).filter {$0.recType == type.rawValue}
        if items.isEmpty {
            return print("TypeRemove: Type not found")
        }
        list.removeFromListToRecycle(items[0])
    }
    
    static func getRecylces(_ list: ShoppingList) -> [RecycleItem] {
        guard let data = list.listToRecycle else { return [] }
        return data.allObjects as! [RecycleItem]
    }
    
    static func getRecylcesDict(_ list: ShoppingList) -> [RecycleTypes: Int] {
        var dict: [RecycleTypes: Int] = [:]
        for type in RecycleTypes.allCases { dict[type] = 0 }

        let data = getRecylces(list)
        
        for type in RecycleTypes.allCases {
            dict[type] = data.filter {$0.recType == type.rawValue}.count
        }
        return dict
    }
    
}

// MARK: History
extension CoreData {
    /// Returns an array of all histories
    static func getHistory() -> [Item] {
        guard let data = Util.getAppData().historys else {
            return []
        }
        
        return data.allObjects as! [Item]
    }
    
    /// addt item to history
    static func addHistory(_ item: Item) {
        let history = getHistory()
        let previous = history.filter {$0.number == item.number}
        previous.forEach { oldSave in
            CoreData.removeHistory(oldSave)
        }
        
        Util.getAppData().addToHistorys(item)
        try! context.save()
    }
    
    /// remove item from history
    static func removeHistory(_ item: Item) {
        let history = Util.getAppData()
        history.removeFromHistorys(item)
    }
    
}
