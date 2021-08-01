//
//  AddEmployeeModel.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 01.08.2021.
//

import Foundation

struct AddEmployeeModel {

    let name: String
    let salary: Int
    let receptionHours: String?
    let workplaceNumber: String?
    let lunchTime: String?
    let accountantType: AccountantType?

    init(
        name: String = "",
        salary: Int = 0,
        receptionHours: String? = nil,
        workplaceNumber: String? = nil,
        lunchTime: String? = nil,
        accountantType: AccountantType? = nil
    ) {
        self.name = name
        self.salary = salary
        self.receptionHours = receptionHours
        self.workplaceNumber = workplaceNumber
        self.lunchTime = lunchTime
        self.accountantType = accountantType
    }
}
