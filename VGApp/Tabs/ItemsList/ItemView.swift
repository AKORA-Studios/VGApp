//
//  ItemView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI

struct Itemview: View {
    @ObservedObject var vm: ItemViewmodel
    
    var body: some View {
        NavigationView {
            VStack {
                if vm.items.isEmpty {
                    Spacer()
                    Text("itemView_noItems")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                    Spacer()
                }
                
                List {
                    ForEach(vm.items) { item in
                        ItemCell(item: item)
                    }.onDelete { indexSet in
                        vm.removeItems(at: indexSet)
                    }
                    
                    if vm.list != nil && !CoreData.getRecylces(vm.list!).isEmpty {
                        recycleSection()
                    }
                    
                    if !vm.items.isEmpty {
                        Text("itemView_deleteAllItems")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .onTapGesture {
                                vm.showDeleteAlert = true
                            }
                    }
                }.listStyle(.insetGrouped)
            }.navigationTitle("itemView_title")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .automatic) {
                        Button("itemView_newItem_title") {
                            vm.showNewItemSheet()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("itemView_newRecycle_title") {
                            vm.showNewRecycleSheet()
                        }
                    }
                }
        }
        .sheet(isPresented: $vm.showsSheet) {
            switch vm.selectedSheetType {
            case .newItem:
                newItemView()
            case .newRecycle:
                newRecycleView()
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
            message: Text("itemView_deleteAll_AlertTitle"),
            primaryButton: .destructive(Text("alert_action_delete"), action: {
                vm.deleteItems()
            }),
            secondaryButton: .default(Text("alert_action_cancel"), action: {
            })
        )
    }
    
    func newItemView() -> some View {
        ScrollView {
            VStack {
                Spacer()
                Text("newItem_title").font(.title)
                Spacer().frame(height: 50)
                ZStack {
                    TextField("newItem_item_name", text: $vm.newName)
                        .padding()
                    RoundedRectangle(cornerRadius: 8).fill(.clear)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                        .frame(height: 30)
                }
                
                ZStack {
                    TextField("newItem_item_code", text: $vm.newNumber)
                        .padding()
                        .keyboardType(.numberPad)
                        .onChange(of: vm.newNumber) { _ in
                            if vm.newNumber.count > 4 {
                                vm.newNumber = String(vm.newNumber.prefix(4))
                            }
                        }
                    RoundedRectangle(cornerRadius: 8).fill(.clear)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                        .frame(height: 30)
                }
                Spacer().frame(height: 50)
                Button {
                    vm.createItem()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8).fill(.green).frame(height: 40)
                        Text("newItem_add_button_title").foregroundColor(.white)
                    }
                }
                Spacer()
            }.padding(10)
        }.onAppear {
            vm.updateViews()
        }
    }
    
    func recycleSection() -> some View {
        return  Section(header: Text("itemView_section_recycle")) {
            ForEach(vm.usedRecycleTypes, id: \.self) { type in
                HStack {
                    IconManager.recycleIcon(type)!
                        .resizable()
                        .frame(width: 25, height: 25)
                        .colorMultiply(.gray)
                    
                    Text(Util.recTypeName(type))
                    Spacer()
                    Text(String(vm.recycleDict[type] ?? 0))
                } .swipeActions(edge: .trailing) {
                    Button(action: { vm.addRecyle(for: type) }) {
                        Label("+", systemImage: "plus")
                    }.tint(.green)
                    Button(action: { vm.removeRecyle(for: type) }) {
                        Label("-", systemImage: "minus")
                    }.tint(.red)
                }
            }
        }
    }
    
    func newRecycleView() -> some View {
        VStack {
            Text("newRecycle_title").font(.title)
                .padding(.bottom, 20)
                .padding(.top, 20)
            
            ForEach(Array(vm.typeArr.enumerated()), id: \.offset) {  _, type in
                Button(Util.recTypeName(type)) {
                    vm.addRecyle(type)
                    vm.setUsedRecyleTypesArr()
                }.buttonStyle(.bordered)
            }
            .padding(.bottom, 30)
        }
        .padding()
    }
}
