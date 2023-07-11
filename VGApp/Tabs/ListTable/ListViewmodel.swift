//
//  ListTable.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

class ListViewmodel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    @Published var listSections: [String] = []
    @Published var appData: AppData?
    @Published var selected: ShoppingList?
    
    @Published var showDeleteAlert = false
    
    func updateViews() {
        withAnimation {
        self.objectWillChange.send()
        appData = Util.getAppData()
        lists = Util.getLists()
        listSections = getMonths()
        selected = Util.getSelectedList()
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = lists[i]
            CoreData.removeList(theItem)
            if selected == theItem {
                Util.getAppData().selected = nil
            }
            updateViews()
        }
    }
    
    func addList() {
        let newList = Util.createNewList()
        Util.getAppData().selected = newList
        updateViews()
    }
    
    func getMonths() -> [String] {
        let myArray = lists.map { getMonthString($0.date) }
        return myArray
            .enumerated()
            .filter { myArray.firstIndex(of: $0.1) == $0.0 }
            .map { $0.1 }
    }
    
    func getMonthString(_ month: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM - yy"
        
        return formatter.string(from: month)
    }
    
    func getListsForMonth(_ month: String) -> [ShoppingList] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM - yy"
        
        return lists.filter { formatter.string(from: $0.date) == month}
    }
}
