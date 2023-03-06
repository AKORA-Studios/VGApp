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
            
            if(items.isEmpty){
                let item = AppData(context: context)
                try! context.save()
                return item
            }
            return items[0]
        }
        catch {}
        return nil
    }
    
    /// Returns an array of all Lists
    static func getAlllLists() -> [ShoppingList] {
        let data = getCoreData()!.lists
        if(data == nil) { return []}
        let lists = data!.allObjects as! [ShoppingList]?
        if(lists != nil){
            return lists!.sorted(by: {$0.date > $1.date})
        } else {return []}
    }
    
    /// addt item to specific shoppinglist
    static func addItem(_ item: Item, _ list: ShoppingList){
      //  let context = CoreDataStack.shared.managedObjectContext
        let allLists = getAlllLists()
        if(allLists.isEmpty) { return }
        
        let data = (getAlllLists().filter{$0.objectID == list.objectID})[0]
        data.addToItems(item)
        try! context.save()
    }
    
    /// remove item form specific shoppinglist
    static func removeItem(_ item: Item, _ list: ShoppingList){
        //let context = CoreDataStack.shared.managedObjectContext
        let allLists = getAlllLists()
        if(allLists.isEmpty) { return }
        
        let data = (getAlllLists().filter{$0.objectID == list.objectID})[0]
        data.removeFromItems(item)
        try! context.save()
    }
    
    /// create list
    static func addList(_ list: ShoppingList){
     //   let context = CoreDataStack.shared.managedObjectContext
        let data = getCoreData()!
        data.addToLists(list)
        try! context.save()
    }
    
    /// delete list
    static func removeList(_ list: ShoppingList){
      //  let context = CoreDataStack.shared.managedObjectContext
        let data = getCoreData()
        data?.removeFromLists(list)
        try! context.save()
    }
    
    /// Get all items of a list
    static func getListItems(_ list: ShoppingList) -> [Item] {
        if(list.items.allObjects.isEmpty){ return []}
        if(list.items.count == 0) { return []}
        return (list.items.allObjects as! [Item]).sorted(by: {$0.name < $1.name})
    }
    
}

//MARK: History
extension CoreData {
    /// Returns an array of all histories
    static func getHistory() -> [Item] {
        let data = Util.getAppData().historys
        if(data?.allObjects == nil) { return [] }
        
        let lists = data?.allObjects as! [Item]? ?? []
        return lists
    }
    
    /// addt item to history
    static func addHistory(_ item: Item){
        let history = getHistory()
        let previous = history.filter{$0.number == item.number}
        previous.forEach { oldSave in
            CoreData.removeHistory(oldSave)
        }

        Util.getAppData().addToHistorys(item)
        try! context.save()
    }
    
    /// remove item from history
    static func removeHistory(_ item: Item){
        let history = Util.getAppData()
        history.removeFromHistorys(item)
    }

}
