//
//  ItemView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct Itemview: View {
    @State var items = CoreData.getListItems(CoreData.getLastLlist()!)!
    @State var showNewItemSheet = false
    @State var newName = ""
    @State var newNumber = ""
    
    var body: some View {
        NavigationView {
            VStack{
                
                
                if(items.isEmpty){
                    Spacer()
                    Text("Keine Items vorhanden").foregroundColor(.gray).font(.largeTitle)
                    Spacer()
                }
                
                List {
            //Sections
                    ForEach(items.sorted( by: {$0.name! < $1.name!})) { item in
                            HStack{
                                Text(item.name!)
                                Spacer()
                                Text(item.number!).foregroundColor(.gray)
                            }
                        }.onDelete { indexSet in
                            withAnimation {
                                removeItems(at: indexSet)
                                items = CoreData.getListItems(CoreData.getLastLlist()!)!
                            }
                        
                    }
                    
                    if(!items.isEmpty){
                        Text("Alle Items löschen")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .onTapGesture {
                                withAnimation {
                                    Util.deleteAllItems(CoreData.getLastLlist()!)
                                    items = CoreData.getListItems(CoreData.getLastLlist()!)!
                                }
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
                        Util.createItem(CoreData.getLastLlist()!, newName, newNumber)
                        items = CoreData.getListItems(CoreData.getLastLlist()!)!
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
            items = CoreData.getListItems(CoreData.getLastLlist()!)!
        }
       
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = items[i]
            CoreData.removeItem(theItem, CoreData.getLastLlist()!)
        }
    }
    
    func createItem(name: String = "neuesItem", number: String = "0000"){
        
    }
}

class ItemviewwHostingController: UIHostingController<Itemview>  {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: Itemview()
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
