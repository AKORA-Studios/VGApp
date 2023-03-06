//
//  Item+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var icon: String
    @NSManaged public var name: String
    @NSManaged public var number: String
    @NSManaged public var itemTolist: ShoppingList

}

extension Item : Identifiable {

}
