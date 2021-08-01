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

    @NSManaged public var name: String
    @NSManaged public var salary: Int64
    @NSManaged public var employeeType: EmployeeType
    @objc public var isFulfilled: Bool {
        !name.isEmpty && salary != 0
    }

}

@objc public enum EmployeeType: Int64, CaseIterable {
    case employee
    case accountant
    case management

    var title: String {
        switch self {
        case .employee:         return R.string.localizable.employee()
        case .accountant:       return R.string.localizable.accountant()
        case .management:       return R.string.localizable.management()
        }
    }
}
