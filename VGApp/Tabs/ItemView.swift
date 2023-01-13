//
//  ItemView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct Itemview: View {
    @State var items = CoreData.getListItems(CoreData.getLastLlist()!)!
    
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
                        ForEach(items) { item in
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
                            Util.createItem(CoreData.getLastLlist()!, "name", "1234")
                            items = CoreData.getListItems(CoreData.getLastLlist()!)!
                        }
                        
                    }
                }
        }.onAppear{
            items = CoreData.getListItems(CoreData.getLastLlist()!)!
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for i in offsets.makeIterator() {
            let theItem = items[i]
            CoreData.removeItem(theItem, CoreData.getLastLlist()!)
        }
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
