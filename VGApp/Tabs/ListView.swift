//
//  LlistView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct ListView: View{
    @State var models = CoreData.getAlllLists()!
    @State var showListDetail = false
    @State var selectedList: ShoppingList?
    
    var body: some View {
        NavigationView {
            VStack{
                if(models.isEmpty){
                    Spacer()
                    Text("Keine Listen vorhanden").foregroundColor(.gray).font(.largeTitle)
                    Spacer()
                }
                
                List {
                    //Sections
                    ForEach(models) { list in
                        HStack{
                            if(models.first == list) {
                                Image(systemName: "star.fill")
                            }
                            Text(list.date.format())
                            Spacer()
                            Text("Items: \(list.items?.count == 0 ? 0 : list.items!.count)").foregroundColor(.gray)
                        }.onTapGesture {
                            selectedList = list
                            showListDetail = true
                        }.disabled(list.items?.count == 0)
                    }.onDelete { indexSet in
                        withAnimation {
                            removeItems(at: indexSet)
                        models = CoreData.getAlllLists()!
                        }
                    }
                    
                    if(!models.isEmpty){
                        Text("Alle Listen löschen")
                            .foregroundColor(.red)
                            .listRowBackground(Color.red.opacity(0.4))
                            .onTapGesture {
                                withAnimation {
                                Util.deleteAllLists()
                                models = CoreData.getAlllLists()!
                                }
                            }
                    }
                }
                
            }.navigationTitle("Einkauflisten")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Neue Liste") {
                        withAnimation {
                            models.append(Util.createNewList())
                        }
                        
                    }
                }
        }.onAppear{
            models = CoreData.getAlllLists()!
        }
        .sheet(isPresented: $showListDetail) {
            if(selectedList != nil){
                ListDetail(list: selectedList!).onDisappear{
                    selectedList = nil
                }
            }
            if(selectedList == nil){
                Text("Etwas ist schief gegangen")
            }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = models[i]
            CoreData.removeList(theItem)
        }
    }
}

struct ListViewPreview: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

class ListViewHostingController: UIHostingController<ListView>  {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: ListView()
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
