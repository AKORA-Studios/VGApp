//
//  Barcodes+CoreDataProperties.swift
//  
//
//  Created by Kiara on 06.03.23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Barcodes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Barcodes> {
        return NSFetchRequest<Barcodes>(entityName: "Barcodes")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var historytoappdata: AppData?

}

extension Barcodes : Identifiable {

}
