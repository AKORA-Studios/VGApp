//
//  ListDetailView.swift
//  VGApp
//
//  Created by Kiara on 19.01.23.
//

import SwiftUI

struct ListDetail: View {
    @ObservedObject var vm: ListDetailViewModel
    
    var body: some View {
        VStack{
            List {
                Section {
                    HStack {
                        Text("Erstellungsdatum: ")
                        Spacer()
                        Text(vm.list.date.format())
                    }
                    HStack {
                        Text("Ist Liste Aktiv: ")
                        Spacer()
                        Text(vm.isActive ? "ja" : "nein")
                            .foregroundColor(vm.isActive ? .green : .red)
                    }
                }
                
                Section {
                    ForEach(CoreData.getListItems(vm.list)) { item in
                        ItemCell(item: item)
                    }
                }
                
                Section {
                    Text(vm.isActive ? "Liste deaktivieren" : "Liste aktivieren")
                        .foregroundColor(vm.isActive ? .red : .green)
                        .onTapGesture {
                            vm.changeSelection()
                        }
                }
            }
        }
        .navigationTitle("Listeninhalt")
        .onAppear{
            vm.checkActive()
        }
    }
}


class ListDetailViewModel: ObservableObject {
    @Published var list: ShoppingList
    @Published var isActive = false
    
    init(list: ShoppingList) {
        self.list = list
    }
    
    func checkActive() {
        isActive = Util.getAppData().selected == list
    }
    
    func changeSelection(){
        if(isActive){
            Util.getAppData().selected = nil
            Util.save()
        } else {
            Util.getAppData().selected = list
            Util.save()
        }
        isActive = Util.getAppData().selected == list
    }
}
