//
//  ListDetailView.swift
//  VGApp
//
//  Created by Kiara on 19.01.23.
//

import SwiftUI


struct ListDetail: View {
    @State var list: ShoppingList
    
    var body: some View {
            VStack{
                Spacer()
                Text("Inhalt")
                List {
                    ForEach(CoreData.getListItems(list)!) { item in
                        HStack{
                            Text(item.name ?? "Namenlos")
                            Spacer()
                            Text(item.number ?? "####").foregroundColor(.gray)
                        }
                    }
                }
              
            }
    }
}
