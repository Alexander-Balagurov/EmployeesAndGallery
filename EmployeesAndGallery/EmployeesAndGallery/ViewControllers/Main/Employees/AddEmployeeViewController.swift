//
//  AddEmployeeViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit
import CoreData

final class AddEmployeeViewController: BaseViewController {

    // MARK: - Private
    private let tableView: UITableView = .init(frame: .zero)
    private let headerView: SegmentControlHeaderView = .loadFromNib()
    private var baseEmployee: BaseEmployee
    private var context: NSManagedObjectContext?

    //MARK: - Init
    init(baseEmployee: BaseEmployee, context: NSManagedObjectContext?) {
        self.baseEmployee = baseEmployee
        self.context = context

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        static func cellTypesForEmployee(type: BaseEmployee) -> [CellType] {

            switch type {
            case _ as Accountant:
                return [.name, .salary, .workplaceNumber, .lunchTime, .accountantType]
            case _ as Employee:
                return [.name, .salary, .workplaceNumber, .lunchTime]
            case _ as Management:
                return [.name, .salary, .receptionHours]
            default:
                return [.name, .salary]
            }
        }
    }

    func initialSetup() {

        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(tableView)
        setupTableView()
        headerView.segmentControl.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
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

    func createAccountantTypePicker() -> UIPickerView {

        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        return picker
    }

    //MARK: - Actions

    @objc func saveButtonTapped() {

    }

    @objc func segmentDidChange() {
        switch headerView.segmentControl.selectedSegmentIndex {
        case 0:
            baseEmployee = Employee()
        case 1:
            baseEmployee = Accountant()
        case 2:
            baseEmployee = Management()
        default:
            break
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension AddEmployeeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.cellTypesForEmployee(type: baseEmployee).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellType = CellType.cellTypesForEmployee(type: baseEmployee)[indexPath.row]
        let cell: AddEmployeeTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        cell.titleLabel.text = cellType.titleText
        if cellType == .accountantType {
            cell.valueTextfield.inputView = createAccountantTypePicker()
            cell.valueTextfield.tintColor = .clear
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

        return AccountantType.allCases[row].title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let accountantTypeIndex = CellType.cellTypesForEmployee(type: baseEmployee).firstIndex(of: .accountantType) else {
            return
        }
        let cell: AddEmployeeTableViewCell = tableView.cellForRow(
            at: IndexPath(row: accountantTypeIndex, section: 0)
        ) as! AddEmployeeTableViewCell
        cell.valueTextfield.text = AccountantType.allCases[row].title
    }
}
