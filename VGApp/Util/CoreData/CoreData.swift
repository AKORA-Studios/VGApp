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
        let context = CoreDataStack.shared.managedObjectContext
        
        var items: [AppData]
        do {
            items = try context.fetch(AppData.fetchRequest())
            
            if(items.count == 0){
                let item = AppData(context: context)
                try! context.save()
                return item
            }
            return items[0]
        }
        catch {}
        return nil
    }
    
    /// Returns the latest List, sorted by date
    static func getLastLlist() -> ShoppingList? {
        var allLists: [ShoppingList] = getAlllLists()!
        
        if(allLists.count == 0) {
        _ = Util.createNewList()
        allLists = getAlllLists()!
           }
        
        allLists = allLists.sorted(by: {$0.date! > $1.date!})
        return allLists[0]
    }
    
    /// Returns an array of all Lists
    static func getAlllLists() -> [ShoppingList]? {
        let data = getCoreData()!.lists
        if(data == nil) { return []}
        return data!.allObjects as! [ShoppingList]?
    }
    
    /// addt item to specific shoppinglist
    static func addItem(_ item: Item, _ list: ShoppingList){
        let context = CoreDataStack.shared.managedObjectContext
        let allLists = getAlllLists()
        if(allLists == nil) { return }
        
        let data = (getAlllLists()!.filter{$0.objectID == list.objectID})[0]
        data.addToItems(item)
        try! context.save()
    }
    
    /// remove item form specific shoppinglist
    static func removeItem(_ item: Item, _ list: ShoppingList){
        let context = CoreDataStack.shared.managedObjectContext
        let allLists = getAlllLists()
        if(allLists == nil) { return }
        
        let data = (getAlllLists()!.filter{$0.objectID == list.objectID})[0]
        data.removeFromItems(item)
        try! context.save()
    }
    
    /// create list
    static func addList(_ list: ShoppingList){
        let context = CoreDataStack.shared.managedObjectContext
        let data = getCoreData()!
        data.addToLists(list)
        try! context.save()
    }
    
    /// delete list
    static func removeList(_ list: ShoppingList){
        let context = CoreDataStack.shared.managedObjectContext
        let data = getCoreData()
        data?.removeFromLists(list)
        try! context.save()
    }
    
    /// Get all items of a list
    static func getListItems(_ list: ShoppingList) -> [Item]? {
        if(list.items == nil){ return []}
        if(list.items!.count == 0) { return []}
        return (list.items!.allObjects as! [Item]).sorted(by: {$0.name! < $1.name!})
    }
    
}
