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

    @NSManaged public var accountantType: AccountantType
}

@objc public enum AccountantType: Int64, CaseIterable {
    case payroll
    case materialsAccounting

    var title: String {
        switch self {
        case .payroll:                  return R.string.localizable.payroll()
        case .materialsAccounting:      return R.string.localizable.materialsAccounting()
        }
    }
}
