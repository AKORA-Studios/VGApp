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
                    Text("Keine Items vorhanden")
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
                        Text("Alle Items löschen")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .onTapGesture {
                                vm.showDeleteAlert = true
                            }
                    }
                }.listStyle(.insetGrouped)
            }.navigationTitle("Übersicht")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .automatic) {
                        Button("+ Item") {
                            vm.showNewItemSheet()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("+ Leergut") {
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
            title: Text("Löschen"),
            message: Text("Sicher das du alle Items dieser Liste löschen möchtest?"),
            primaryButton: .destructive(Text("Löschen"), action: {
                vm.deleteItems()
            }),
            secondaryButton: .default(Text("Stop"), action: {
                
            })
        )
    }
    
    func newItemView() -> some View {
        ScrollView {
            VStack {
                Spacer()
                Text("Neues Item").font(.title)
                Spacer().frame(height: 50)
                ZStack {
                    TextField(" Name", text: $vm.newName)
                        .padding()
                    RoundedRectangle(cornerRadius: 8).fill(.clear)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                        .frame(height: 30)
                }
                
                ZStack {
                    TextField(" Nummer", text: $vm.newNumber)
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
                        Text("Item hinzufügen").foregroundColor(.white)
                    }
                }
                Spacer()
            }.padding(10)
        }.onAppear {
            vm.updateViews()
        }
    }
    
    func recycleSection() -> some View {
        return  Section(header: Text("Recycle")) {
            ForEach(vm.usedRecycleTypes, id: \.self) { type in
                HStack {
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
            
            Text("Neues Leergut").font(.title)
                .padding(.bottom, 20)
                .padding(.top, 20)
            
            Picker("Leergut Typ", selection: $vm.newRecycleType) {
                ForEach(Array(vm.typeArr.enumerated()), id: \.offset) { index, type in
                    Text(Util.recTypeName(type)).tag(index)
                }
            }.pickerStyle(.segmented)
                .colorMultiply(.green)
                .padding(.bottom, 30)
            
            Button {
                vm.addRecyle()
                vm.setUsedRecyleTypesArr()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(.green).frame(height: 40)
                    Text("Leergut hinzufügen").foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}
