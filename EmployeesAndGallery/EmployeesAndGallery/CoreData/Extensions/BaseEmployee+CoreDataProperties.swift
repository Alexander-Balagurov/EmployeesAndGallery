//
//  BaseEmployee+CoreDataProperties.swift
//  
//
//  Created by Александр Балагуров on 31.07.2021.
//
//

import Foundation
import CoreData


extension BaseEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseEmployee> {
        return NSFetchRequest<BaseEmployee>(entityName: "BaseEmployee")
    }

    @NSManaged public var name: String?
    @NSManaged public var salary: Int64

}
