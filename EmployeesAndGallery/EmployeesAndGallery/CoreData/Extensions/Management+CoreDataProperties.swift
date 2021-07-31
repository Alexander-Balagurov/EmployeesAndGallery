//
//  Management+CoreDataProperties.swift
//  
//
//  Created by Александр Балагуров on 31.07.2021.
//
//

import Foundation
import CoreData


extension Management {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Management> {
        return NSFetchRequest<Management>(entityName: "Management")
    }

    @NSManaged public var receptionHours: String?

}
