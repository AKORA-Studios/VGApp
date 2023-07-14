//
//  ListDetailView.swift
//  VGApp
//
//  Created by Kiara on 19.01.23.
//

import SwiftUI

struct ListDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: ListDetailViewModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text("listDetailView_list_creationDate")
                        Spacer()
                        Text(vm.list.date.format())
                    }
                    HStack {
                        Text("listDetailView_list_isActive")
                        Spacer()
                        Text(vm.isActive ? "listDetailView_list_isActive_yes" : "listDetailView_list_isActive_no")
                            .foregroundColor(vm.isActive ? .green : .red)
                    }
                }
                
                if vm.items.isEmpty {
                    Text("itemView_noItems")
                } else {
                    Section(header: Text("Items")) {
                        ForEach(vm.items) { item in
                            ItemCell(item: item)
                        }
                    }
                }
              
                if !CoreData.getRecylces(vm.list).isEmpty {
                    recycleSection()
                }
                
                Section {
                    Text(vm.isActive ? "listDetailView_list_isActive_ChangeTo_no" : "listDetailView_list_isActive_ChangeTo_yes")
                        .foregroundColor(vm.isActive ? .red : .green)
                        .onTapGesture {
                            vm.changeSelection()
                        }
                    
                    Text("listDetailView_list_delete")
                        .foregroundColor(.red)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                            CoreData.removeList(vm.list)
                        }
                }
            }
        }
        .navigationTitle("listDetailView_title")
        .onAppear {
            vm.update()
        }
    }
    
    func recycleSection() -> some View {
        let dict = CoreData.getRecylcesDict(vm.list)
        return  Section(header: Text("itemView_section_recycle")) {
            ForEach(RecycleTypes.allCases, id: \.self) { type in
                if dict[type] != 0 {
                    HStack {
                        Text(Util.recTypeName(type))
                        Spacer()
                        Text(String(dict[type] ?? 0))
                    }
                }
            }
        }
    }
}

class ListDetailViewModel: ObservableObject {
    @Published var list: ShoppingList
    @Published var items: [Item] = []
    @Published var isActive = false
    
    init(list: ShoppingList) {
        self.list = list
        update()
    }
    
    func update() {
        items = CoreData.getListItems(list)
        checkActive()
    }
    
    func checkActive() {
        isActive = Util.getAppData().selected == list
    }
    
    func changeSelection() {
        if isActive {
            Util.getAppData().selected = nil
            Util.save()
        } else {
            Util.getAppData().selected = list
            Util.save()
        }
        isActive = Util.getAppData().selected == list
    }
}
