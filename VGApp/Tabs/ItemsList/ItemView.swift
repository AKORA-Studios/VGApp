//
//  ItemView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct Itemview: View {
    @ObservedObject var vm: ItemViewmodel
    
    @State var showNewItemSheet = false
    @State var newName = ""
    @State var newNumber = ""
    
    var body: some View {
        NavigationView {
            VStack{
                
                if(vm.items.isEmpty){
                    Spacer()
                    Text("Keine Items vorhanden").foregroundColor(.gray).font(.largeTitle)
                    Spacer()
                }
                
                List {
                    ForEach(vm.items) { item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text(item.number).foregroundColor(.gray)
                        }
                    }.onDelete { indexSet in
                        vm.removeItems(at: indexSet)
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
                    Button("Neues Item") {
                        withAnimation {
                            showNewItemSheet.toggle()
                        }
                        
                    }
                }
        } .sheet(isPresented: $showNewItemSheet) {
            ScrollView{
                VStack {
                    Spacer()
                    Text("Neues Item").font(.title)
                    Spacer().frame(height: 50)
                    ZStack {
                        TextField(" Name", text: $newName)
                        RoundedRectangle(cornerRadius: 8).fill(.clear)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                            .frame(height: 30)
                    }
                    
                    ZStack{
                        TextField(" Nummer", text: $newNumber).keyboardType(.numberPad).onChange(of: newNumber) { newValue in
                            if(newNumber.count > 4){
                                newNumber = String(newNumber.prefix(4))
                            }
                        }
                        RoundedRectangle(cornerRadius: 8).fill(.clear)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.green, lineWidth: 2))
                            .frame(height: 30)
                    }
                    Spacer().frame(height: 50)
                    Button {
                        Util.createItem(name: newName, code: newNumber)
                        vm.updateViews()
                        showNewItemSheet.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8).fill(.green).frame(height: 40)
                            Text("Item hinzufügen").foregroundColor(.white)
                        }
                    }
                    Spacer()
                }.padding(10)
            }.onAppear{
                newNumber = ""
                newName = ""
            }
        }
        .onAppear{
            vm.updateViews()
        }
    }
    
    func createItem(name: String = "neuesItem", number: String = "0000"){
        
    }
}
