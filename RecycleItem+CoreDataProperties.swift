//
//  RecycleItem+CoreDataProperties.swift
//  VGApp
//
//  Created by Kiara on 24.06.23.
//
//

import Foundation
import CoreData


extension RecycleItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecycleItem> {
        return NSFetchRequest<RecycleItem>(entityName: "RecycleItem")
    }

    @NSManaged public var recType: String

}

extension RecycleItem : Identifiable {

}
