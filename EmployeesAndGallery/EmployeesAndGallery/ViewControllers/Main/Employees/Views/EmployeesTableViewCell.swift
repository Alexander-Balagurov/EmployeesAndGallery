//
//  EmployeesTableViewCell.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 01.08.2021.
//

import UIKit

final class EmployeesTableViewCell: UITableViewCell {

    //MARK: - Private properties
    @IBOutlet private var nameLabel: UILabel!

    @IBOutlet private var salaryLabel: UILabel!
    @IBOutlet private var salaryValueLabel: UILabel!

    @IBOutlet private var workplaceLabel: UILabel!
    @IBOutlet private var workplaceValueLabel: UILabel!
    @IBOutlet private var workplaceSV: UIStackView!

    @IBOutlet private var lunchLabel: UILabel!
    @IBOutlet private var lunchValueLabel: UILabel!
    @IBOutlet private var lunchSV: UIStackView!

    @IBOutlet private var receptionLabel: UILabel!
    @IBOutlet private var receptionValueLabel: UILabel!
    @IBOutlet private var receptionSV: UIStackView!

    @IBOutlet private var accountantTypeLabel: UILabel!
    @IBOutlet private var accountantTypeValueLabel: UILabel!
    @IBOutlet private var accountantTypeSV: UIStackView!


    //MARK: - Public properties
    var viewModel: ViewModel? {
        didSet {
            viewModelDidChange()
        }
    }

    //MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()

        initialSetup()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        salaryValueLabel.text = ""
        workplaceValueLabel.text = ""
        lunchValueLabel.text = ""
        receptionValueLabel.text = ""
        accountantTypeValueLabel.text = ""

        workplaceSV.isHidden = false
        lunchSV.isHidden = false
        receptionSV.isHidden = false
        accountantTypeSV.isHidden = false
    }

    func setupWith(type: EmployeeType) {

        workplaceSV.isHidden = type == .management
        lunchSV.isHidden = type == .management
        receptionSV.isHidden = type != .management
        accountantTypeSV.isHidden = type != .accountant
    }
}

// MARK: - ViewModel
extension EmployeesTableViewCell {

    struct ViewModel {

        let name: String
        let salary: String
        let workplaceNumber: String?
        let lunchTime: String?
        let receptionHours: String?
        let accountantType: String?
    }

    private func viewModelDidChange() {
        guard let viewModel = viewModel else { return }

        nameLabel.text = viewModel.name
        salaryValueLabel.text = viewModel.salary
        workplaceValueLabel.text = viewModel.workplaceNumber
        lunchValueLabel.text = viewModel.lunchTime
        receptionValueLabel.text = viewModel.receptionHours
        accountantTypeValueLabel.text = viewModel.accountantType
    }
}


fileprivate extension EmployeesTableViewCell {

    func initialSetup() {
        layer.cornerRadius = 16
        setupStaticLabels()
    }

    func setupStaticLabels() {
        salaryLabel.text = R.string.localizable.salary()
        workplaceLabel.text = R.string.localizable.workplaceNumber()
        lunchLabel.text = R.string.localizable.lunchTime()
        receptionLabel.text = R.string.localizable.receptionHours()
        accountantTypeLabel.text = R.string.localizable.accountantType()
    }
}
