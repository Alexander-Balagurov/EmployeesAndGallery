//
//  SegmentControlHeaderView.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class SegmentControlHeaderView: UIView {

    @IBOutlet var segmentControl: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()

        configureSegmentControl()
    }
}

fileprivate extension SegmentControlHeaderView {

    func configureSegmentControl() {
        segmentControl.setTitle(EmployeeType.employee.title, forSegmentAt: 0)
        segmentControl.setTitle(EmployeeType.accountant.title, forSegmentAt: 1)
        segmentControl.setTitle(EmployeeType.management.title, forSegmentAt: 2)
    }
}
