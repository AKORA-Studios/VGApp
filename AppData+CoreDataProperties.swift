//
//  AppData+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 08.02.22.
//
//

import Foundation
import CoreData


extension AppData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppData> {
        return NSFetchRequest<AppData>(entityName: "AppData")
    }

    @NSManaged public var lists: NSSet?

}

// MARK: Generated accessors for lists
extension AppData {

    @objc(addListsObject:)
    @NSManaged public func addToLists(_ value: ShoppingList)
    
    @objc(addLists:)
    @NSManaged public func addToLists(_ values: NSSet)


    @objc(removeListsObject:)
    @NSManaged public func removeFromLists(_ value: ShoppingList)

    @objc(removeLists:)
    @NSManaged public func removeFromLists(_ values: NSSet)
}

extension AppData : Identifiable {

}
