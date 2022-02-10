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
}
