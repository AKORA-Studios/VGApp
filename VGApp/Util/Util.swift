//
//  Util.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import Foundation

let context = CoreDataStack.shared.managedObjectContext

struct Util {
    
    
    
    static func getAppData() -> AppData{
        return CoreData.getCoreData()!
    }
    
    static func getLists() -> [ShoppingList] {
        return getAppData().lists?.allObjects as! [ShoppingList]
    }
    
    static func getSelectedList() -> ShoppingList {
        guard let list = getAppData().selected else {
            setSelectedList()
            return getAppData().selected!
        }
       return list
    }
    
    static func setSelectedList(_ list: ShoppingList = createNewList()){
        getAppData().selected = list
        try! context.save()
    }
    
    static func createNewList() -> ShoppingList{
        let newList = ShoppingList(context: context)
        
        newList.date = Date()
        newList.items = []
        
        CoreData.addList(newList)
        try! context.save()
        return newList
    }
    
    static func deleteAllLists(){
        let appData = getAppData()
        appData.lists = []
        try! context.save()
    }
    
    static func deleteAllItems(_ list: ShoppingList) {
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
        
        let newItem = Item(context: context)
        newItem.name = name
        newItem.number = codeArr.joined(separator: "")
        newItem.icon = "apple"
        list.addToItems(newItem)
        try! context.save()
    }
    
}

extension Date{
    func format()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd.MM.yy HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
