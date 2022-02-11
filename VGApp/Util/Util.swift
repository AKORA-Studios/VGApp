//
//  Util.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation


struct Util {
    
    static func createNewList() -> ShoppingList{
        let context = CoreDataStack.shared.managedObjectContext
        let newList = ShoppingList(context: context)
        
        newList.date = Date()
        newList.items = []
    
        CoreData.addList(newList)
        try! context.save()
        return newList
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
    
    static func createItem(_ list: ShoppingList, _ name: String, _ code: String){
        var codeArr = code.map{ String($0)}

        for _ in 1...4{
            if(codeArr.count < 4){
                codeArr.append("0")
            }
        }
        
        let context = CoreDataStack.shared.managedObjectContext
        let newItem = Item(context: context)
        newItem.name = name
        newItem.number = codeArr.joined(separator: "")
        newItem.icon = "apple"
        list.addToItems(newItem)
        try! context.save()
    }
    
 
}
