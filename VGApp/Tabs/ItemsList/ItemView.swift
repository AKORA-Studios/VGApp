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
            VStack{
                if vm.items.isEmpty {
                    Spacer()
                    Text("Keine Items vorhanden").foregroundColor(.gray).font(.largeTitle)
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
                    
                    if(!vm.items.isEmpty){
                        Text("Alle Items löschen")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .onTapGesture {
                                vm.deleteItems()
                            }
                    }
                }
            }.navigationTitle("Übersicht")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    
                    ToolbarItem(placement: .automatic) {
                        Button("+ Item") {
                            withAnimation {
                                vm.showNewItemSheet.toggle()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("+ Leergut") {
                            withAnimation {
                                vm.showNewItemSheet.toggle()
                            }
                        }
                    }
                    
                    
                }
        }
        .sheet(isPresented: $vm.showNewItemSheet) {newItemView()}
        .sheet(isPresented: $vm.showNewRecycleSheet) {newRecycleView()}
        .onAppear{
            vm.updateViews()
        }
    }
    
    func newItemView() -> some View {
        ScrollView{
            VStack {
                Spacer()
                Text("Neues Item").font(.title)
                Spacer().frame(height: 50)
                ZStack {
                    TextField(" Name", text: $vm.newName)
                    RoundedRectangle(cornerRadius: 8).fill(.clear)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                        .frame(height: 30)
                }
                
                ZStack{
                    TextField(" Nummer", text: $vm.newNumber).keyboardType(.numberPad).onChange(of: vm.newNumber) { newValue in
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
                    Util.createItem(name: vm.newName, code: vm.newNumber)
                    vm.updateViews()
                    vm.showNewItemSheet.toggle()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8).fill(.green).frame(height: 40)
                        Text("Item hinzufügen").foregroundColor(.white)
                    }
                }
                Spacer()
            }.padding(10)
        }.onAppear{
            vm.newNumber = ""
            vm.newName = ""
        }
    }
    
    func recycleSection() -> some View {
        let dict = CoreData.getRecylcesDict(vm.list!)
        
        return  Section(header: Text("Recycle")) {
            ForEach(RecycleTypes.allCases, id: \.self) { type in
                if dict[type] != 0 {
                Text(String(dict[type] ?? 0))
                }
            }
        }
    }
    
    func newRecycleView() -> some View {
        Text("ayo")
    }
}
