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
    
    static func save() {
        try! context.save()
    }
    
    static func getAppData() -> AppData {
        return CoreData.getCoreData()!
    }
    
    static func getLists() -> [ShoppingList] {
        return CoreData.getAlllLists()
    }
    
    static func getSelectedList() -> ShoppingList {
        guard let list = getAppData().selected else {
            setSelectedList()
            return getAppData().selected!
        }
        return list
    }
    
    static func setSelectedList(_ list: ShoppingList = createNewList()) {
        getAppData().selected = list
        save()
    }
    
    static func createNewList() -> ShoppingList {
        let newList = ShoppingList(context: context)
        
        newList.date = Date()
        newList.items = []
        
        CoreData.addList(newList)
        save()
        return newList
    }
    
    static func getItems(_ list: ShoppingList = getSelectedList()) -> [Item] {
        return CoreData.getListItems(list)
    }
    
    static func deleteAllLists() {
        let appData = getAppData()
        appData.selected = nil
        appData.lists = []
        save()
    }
    
    static func deleteAllItems(_ list: ShoppingList) {
        list.items = []
        list.listToRecycle = []
        save()
    }
    
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
    
    static func recTypeName(_ type: RecycleTypes) -> String {
        switch type {
        case .yoghurtglass:
            return "Jogurtglas"
        case .bottle:
            return "Flasche"
        case .crate:
            return "Kasten"
        }
    }
    
}

extension Date {
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE dd.MM.yy HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
