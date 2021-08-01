//
//  AddEmployeeTableViewCell.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class AddEmployeeTableViewCell: UITableViewCell {

    //MARK: - Public properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueTextfield: UITextField!

    //MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = ""
        valueTextfield.text = ""
        valueTextfield.keyboardType = .default
    }
}
