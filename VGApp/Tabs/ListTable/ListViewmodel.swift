//
//  ListTable.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI


class ListViewmodel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    @Published var appData: AppData?
    @Published var selected: ShoppingList?
    
    func updateViews(){
        withAnimation{
        self.objectWillChange.send()
        appData = Util.getAppData()
        lists = Util.getLists()
        selected = Util.getSelectedList()
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = lists[i]
            CoreData.removeList(theItem)
            if(selected == theItem){
                Util.getAppData().selected = nil
            }
            updateViews()
        }
    }
    
    func addList(){
        let newList = Util.createNewList()
        Util.getAppData().selected = newList
        updateViews()
    }
}
