//
//  AddEmployeeViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class AddEmployeeViewController: BaseViewController {

    // MARK: - Private
    private let tableView: UITableView = .init(frame: .zero)
    private let headerView: SegmentControlHeaderView = .loadFromNib()
    private var addEmployeeModel: AddEmployeeModel = .init()

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
}

fileprivate extension AddEmployeeViewController {

    enum CellType: Int, CaseIterable {
        case name, salary, receptionHours, workplaceNumber, lunchTime, accountantType

        init(at indexPath: IndexPath) {
            self = CellType.init(rawValue: indexPath.row)!
        }

        var titleText: String {
            switch self {
            case .name:                 return R.string.localizable.name()
            case .salary:               return R.string.localizable.salary()
            case .receptionHours:       return R.string.localizable.receptionHours()
            case .workplaceNumber:      return R.string.localizable.workplaceNumber()
            case .lunchTime:            return R.string.localizable.lunchTime()
            case .accountantType:       return R.string.localizable.accountantType()
            }
        }
    }

    func initialSetup() {

        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(tableView)
        setupTableView()
    }

    func configureNavigationBar() {

        title = R.string.localizable.edit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: R.string.localizable.save(),
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }

    func setupTableView() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        headerView.frame.size.height = 50
        tableView.tableHeaderView = headerView
        tableView.registerNibForCell(AddEmployeeTableViewCell.self)
        tableView.backgroundColor = .white
        tableView.layout {
            $0.top == view.topAnchor
            $0.bottom == view.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
    }

    func createFontSizePicker() -> UIPickerView {

        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return picker
    }

    //MARK: - Actions

    @objc func saveButtonTapped() {

    }
}

// MARK: - UITableViewDataSource
extension AddEmployeeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = CellType.init(at: indexPath)
        let cell: AddEmployeeTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        if cellType == .accountantType {
            cell.viewModel = .init(title: cellType.titleText, inputView: createFontSizePicker())
        } else {
            cell.viewModel = .init(title: cellType.titleText)
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension AddEmployeeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {

        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return AccountantType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return "tets"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
}
