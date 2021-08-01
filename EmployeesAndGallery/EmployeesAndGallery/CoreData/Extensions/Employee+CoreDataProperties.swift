//
//  Employee+CoreDataProperties.swift
//  
//
//  Created by Александр Балагуров on 31.07.2021.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var workplaceNumber: Int64
    @NSManaged public var lunchTime: String?

}
