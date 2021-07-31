//
//  Accountant+CoreDataProperties.swift
//  
//
//  Created by Александр Балагуров on 31.07.2021.
//
//

import Foundation
import CoreData


extension Accountant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Accountant> {
        return NSFetchRequest<Accountant>(entityName: "Accountant")
    }

    @NSManaged public var accountantType: Int64

}
