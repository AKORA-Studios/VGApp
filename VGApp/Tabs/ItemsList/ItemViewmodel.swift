//
//  ItemViewmodel.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import SwiftUI

class ItemViewmodel: ObservableObject {
    @Published var list: ShoppingList?
    @Published var items: [Item] = []
    
    func updateViews(){
        withAnimation {
            self.objectWillChange.send()
            list = Util.getSelectedList()
            items = Util.getItems()
        }
    }
    
    func deleteItems(){
        guard let list = list else {
           return
        }
        Util.deleteAllItems(list)
        updateViews()
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = items[i]
            CoreData.removeItem(theItem, list!)
            Util.save()
        }
        updateViews()
    }
}

