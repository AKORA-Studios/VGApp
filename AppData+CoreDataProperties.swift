//
//  AppData+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 06.03.23.
//
//

import Foundation
import CoreData


extension AppData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppData> {
        return NSFetchRequest<AppData>(entityName: "AppData")
    }

    @NSManaged public var lists: NSSet?
    @NSManaged public var selected: ShoppingList?
    @NSManaged public var histories: NSSet?

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

// MARK: Generated accessors for histories
extension AppData {

    @objc(addHistoriesObject:)
    @NSManaged public func addToHistories(_ value: Barcodes)

    @objc(removeHistoriesObject:)
    @NSManaged public func removeFromHistories(_ value: Barcodes)

    @objc(addHistories:)
    @NSManaged public func addToHistories(_ values: NSSet)

    @objc(removeHistories:)
    @NSManaged public func removeFromHistories(_ values: NSSet)

}

extension AppData : Identifiable {

}
