//
//  AddEmployeeTableViewCell.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class AddEmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueTextfield: UITextField!

    var viewModel: ViewModel? {
        didSet {
            viewModelDidChange()
        }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension AddEmployeeTableViewCell {
    struct ViewModel {
        var title: String
        var inputView: UIView? = nil
    }
}

fileprivate extension AddEmployeeTableViewCell {
    func viewModelDidChange() {
        guard let viewModel = viewModel else {
            return
        }

        titleLabel.text = viewModel.title
        valueTextfield.inputView = viewModel.inputView
    }
}
