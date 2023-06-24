//
//  AppData+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 24.06.23.
//
//

import Foundation
import CoreData


extension AppData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppData> {
        return NSFetchRequest<AppData>(entityName: "AppData")
    }

    @NSManaged public var historys: NSSet?
    @NSManaged public var lists: NSSet?
    @NSManaged public var selected: ShoppingList?

}

// MARK: Generated accessors for historys
extension AppData {

    @objc(addHistorysObject:)
    @NSManaged public func addToHistorys(_ value: Item)

    @objc(removeHistorysObject:)
    @NSManaged public func removeFromHistorys(_ value: Item)

    @objc(addHistorys:)
    @NSManaged public func addToHistorys(_ values: NSSet)

    @objc(removeHistorys:)
    @NSManaged public func removeFromHistorys(_ values: NSSet)

}

// MARK: Generated accessors for lists
extension AppData {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: ShoppingList)

    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: ShoppingList)

    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)

}

extension AppData : Identifiable {

}
