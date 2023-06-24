//
//  ShoppingList+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 24.06.23.
//
//

import Foundation
import CoreData


extension ShoppingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingList> {
        return NSFetchRequest<ShoppingList>(entityName: "ShoppingList")
    }

    @NSManaged public var date: Date
    @NSManaged public var items: NSSet?
    @NSManaged public var listToapp: AppData?
    @NSManaged public var listToRecycle: NSSet?

}

// MARK: Generated accessors for items
extension ShoppingList {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

// MARK: Generated accessors for listToRecycle
extension ShoppingList {

    @objc(addListToRecycleObject:)
    @NSManaged public func addToListToRecycle(_ value: RecycleItem)

    @objc(removeListToRecycleObject:)
    @NSManaged public func removeFromListToRecycle(_ value: RecycleItem)

    @objc(addListToRecycle:)
    @NSManaged public func addToListToRecycle(_ values: NSSet)

    @objc(removeListToRecycle:)
    @NSManaged public func removeFromListToRecycle(_ values: NSSet)

}

extension ShoppingList : Identifiable {

}
