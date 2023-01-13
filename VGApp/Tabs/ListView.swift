//
//  LlistView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import SwiftUI


struct ListView: View{
    @State var models = CoreData.getAlllLists()!
    
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
                    ForEach(models.sorted(by: {$0.date! < $1.date!})) { list in
                        HStack{
                            Text(list.date!, style: .date)
                            Text(list.date!, style: .time)
                            Text("Items \(list.items?.count == 0 ? 0 : list.items!.count)").foregroundColor(.gray)
                        }
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
                            Util.createNewList()
                            models = CoreData.getAlllLists()!
                        }
                        
                    }
                }
        }.onAppear{
            models = CoreData.getAlllLists()!
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
