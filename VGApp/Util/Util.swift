//
//  Util.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation


struct Util {
    
    static func createNewList(){
        let context = CoreDataStack.shared.managedObjectContext
        let newList = ShoppingList(context: context)
        
        newList.date = Date.now
        newList.items = []
    
        CoreData.addList(newList)
        try! context.save()
    }
    
    static func deleteAllLists(){
        let context = CoreDataStack.shared.managedObjectContext
        let appData = CoreData.getCoreData()!
        appData.lists = []
        try! context.save()
    }
    
    static func deleteAllItems(_ list: ShoppingList) {
        let context = CoreDataStack.shared.managedObjectContext
        list.items = []
        try! context.save()
    }
    
    static func createItem(_ list: ShoppingList){
        let context = CoreDataStack.shared.managedObjectContext
        let newItem = Item(context: context)
        newItem.name = "Test"
        newItem.number = "1111"
        newItem.icon = "apple"
        list.addToItems(newItem)
        try! context.save()
    }
}
