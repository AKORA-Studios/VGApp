//
//  LlistView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var vm: ListViewmodel
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.lists.isEmpty {
                    Spacer()
                    Text("listView_noLists").foregroundColor(.gray).font(.largeTitle)
                    Spacer()
                }
                
                List {
                    ForEach(vm.listSections, id: \.self) { date in
                        if !vm.getListsForMonth(date).isEmpty {
                            Section(header: Text(date)) {
                                ForEach(vm.getListsForMonth(date)) { list in
                                    let itemsArr = Util.getItems(list)
                                    
                                    NavigationLink(destination: ListDetail(vm: ListDetailViewModel(list: list)).onDisappear(perform: vm.updateViews)) {
                                        HStack {
                                            if list.objectID == vm.selected?.objectID {
                                                Image(systemName: "star.fill")
                                            }
                                            Text(list.date.format())
                                            Spacer()
                                            Text("Recycle: \(Util.getRecycleCount(list))")
                                                .foregroundColor(.gray)
                                                .font(.footnote)
                                            Text("listView_itemCount\(itemsArr.count)").foregroundColor(.gray)
                                                .font(.footnote)
                                        }
                                        
                                    }
                                }.onDelete { indexSet in
                                    vm.removeItems(at: indexSet)
                                }
                            }
                        }
                    }
                    
                    if !vm.lists.isEmpty {
                        Text("listView_deleteAllLists")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .disabled(vm.lists.isEmpty)
                            .onTapGesture {
                                vm.showDeleteAlert = true
                                
                            }
                    }
                }.listStyle(.insetGrouped)
                
            }.navigationTitle("listView_title")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("listView_newList") {
                        vm.addList()
                    }
                }
        }
        .alert(isPresented: $vm.showDeleteAlert) {
            deleteAlert()
        }
        .onAppear {
            vm.updateViews()
        }
    }
    
    func deleteAlert() -> Alert {
        Alert(
            title: Text("alert_title_delete"),
            message: Text("listView_deleteAll_AlertTitle"),
            primaryButton: .destructive(Text("alert_action_delete"), action: {
                Util.deleteAllLists()
                vm.updateViews()
            }),
            secondaryButton: .default(Text("alert_action_cancel"), action: {
                
            })
        )
    }
}

struct ListViewPreview: PreviewProvider {
    static var previews: some View {
        ListView(vm: ListViewmodel())
    }
}
