//
//  ListTable.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//

import Foundation


class ListViewmodel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    @Published var appData: AppData?
    @Published var selected: ShoppingList?
    
    func updateViews(){
        self.objectWillChange.send()
        appData = Util.getAppData()
        lists = Util.getLists()
        selected = Util.getSelectedList()
        print(appData?.selected?.objectID)
        print(lists.map{$0.objectID})
    }
}
