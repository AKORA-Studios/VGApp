//
//  LlistView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct ListView: View{
    @ObservedObject var vm: ListViewmodel
    
    var body: some View {
        NavigationView {
            VStack{
                if(vm.lists.isEmpty){
                    Spacer()
                    Text("Keine Listen vorhanden").foregroundColor(.gray).font(.largeTitle)
                    Spacer()
                }
                
                List {
                    //TODO: Sections after month maybe?
                    ForEach(vm.lists) { list in
                        let itemsArr = Util.getItems(list)
                        
                        NavigationLink(destination: ListDetail(vm: ListDetailViewModel(list: list)).onDisappear(perform: vm.updateViews)) {
                            HStack{
                                if(list.objectID == vm.selected?.objectID) {
                                    Image(systemName: "star.fill")//TODO: whyyyy
                                }
                                Text(list.date.format())
                                Spacer()
                                Text("Items: \(itemsArr.count)").foregroundColor(.gray)
                            }
                            
                        }
                    }.onDelete { indexSet in
                        vm.removeItems(at: indexSet)
                    }
                    
                    if(!vm.lists.isEmpty){
                        Text("Alle Listen löschen") //TODO: alert
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .disabled(vm.lists.isEmpty)
                            .onTapGesture {
                                Util.deleteAllLists()
                                vm.updateViews()
                            }
                    }
                }
                
            }.navigationTitle("Einkauflisten")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Neue Liste") {
                        vm.addList()
                    }
                }
        }.onAppear{
            vm.updateViews()
        }
    }
}

struct ListViewPreview: PreviewProvider {
    static var previews: some View {
        ListView(vm: ListViewmodel())
    }
}
