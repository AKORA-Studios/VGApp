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
    //TODO: items etc., select option
            HStack {
                Text("Erstellungsdatum: ")
                Spacer()
                Text(list.date.format())
            }
            List {
                ForEach(CoreData.getListItems(list)!) { item in
                    HStack{
                        Text(item.name)
                        Spacer()
                        Text(item.number).foregroundColor(.gray)
                    }
                }
            }
        }.padding()
            .navigationTitle("Listeninhalt")
    }
}
