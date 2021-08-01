//
//  EmployeesViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit
import CoreData

final class EmployeesViewController: BaseViewController {

    // MARK: - Public
    var resultActionHandler: (() -> Void)?

    // MARK: - Private
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    private let persistentContainer: PersistentContainer
    private lazy var fetchedResultsController = initializeFetchedResultsController()

    //MARK: - Init
    init(persistentContainer: PersistentContainer) {
        self.persistentContainer = persistentContainer

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

fileprivate extension EmployeesViewController {

    func initializeFetchedResultsController() -> NSFetchedResultsController<BaseEmployee> {

        let request: NSFetchRequest = BaseEmployee.fetchRequest()
        let sortSection = NSSortDescriptor(key: #keyPath(BaseEmployee.employeeType), ascending: true)
        let sortName = NSSortDescriptor(key: #keyPath(BaseEmployee.name), ascending: true)
        request.sortDescriptors = [sortSection, sortName]
        request.fetchBatchSize = 20

        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: #keyPath(BaseEmployee.employeeType),
            cacheName: nil
        )

        controller.delegate = self

        return controller
    }

    func initialSetup() {

        view.backgroundColor = .white
        configureNavigationBar()
        view.addSubview(tableView)
        try? fetchedResultsController.performFetch()
        setupTableView()
    }

    func setupTableView() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = false
        tableView.registerNibForCell(EmployeesTableViewCell.self)
        tableView.backgroundColor = .white
        tableView.layout {
            $0.top == view.topAnchor
            $0.bottom == view.bottomAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
    }

    func configureNavigationBar() {

        title = R.string.localizable.list()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: R.string.localizable.edit(),
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
    }

    //MARK: - Actions
    @objc func editButtonTapped() {
        tableView.isEditing = !tableView.isEditing
    }

    @objc func addButtonTapped() {
        resultActionHandler?()
    }
}

// MARK: - UITableViewDataSource
extension EmployeesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let baseEmployee = fetchedResultsController.object(at: indexPath)
        let cell: EmployeesTableViewCell = tableView.dequeueCell(indexPath: indexPath)
        cell.setupWith(type: baseEmployee.employeeType)
        switch baseEmployee.employeeType {
        case .employee:
            if let employee = baseEmployee as? Employee {
                cell.viewModel = .init(
                    name: employee.name,
                    salary: String(employee.salary),
                    workplaceNumber: String(employee.workplaceNumber),
                    lunchTime: employee.lunchTime,
                    receptionHours: nil,
                    accountantType: nil
                )
            }
        case .accountant:
            if let accountant = baseEmployee as? Accountant {
                cell.viewModel = .init(
                    name: accountant.name,
                    salary: String(accountant.salary),
                    workplaceNumber: String(accountant.workplaceNumber),
                    lunchTime: accountant.lunchTime,
                    receptionHours: nil,
                    accountantType: accountant.accountantType.title
                )
            }
        case .management:
            if let management = baseEmployee as? Management {
                cell.viewModel = .init(
                    name: management.name,
                    salary: String(management.salary),
                    workplaceNumber: nil,
                    lunchTime: nil,
                    receptionHours: management.receptionHours,
                    accountantType: nil
                )
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        guard let object = fetchedResultsController.sections?[section].objects?.first as? BaseEmployee else { return nil }

        return object.entity.name
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let employee = fetchedResultsController.object(at: indexPath)
        persistentContainer.viewContext.delete(employee)
        persistentContainer.viewContext.saveChangesIfNeed()
    }
}


//MARK: - UITableViewDelegate
extension EmployeesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
}

//MARK: - NSFetchedResultsController
extension EmployeesViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {

        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .top)
            break
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .top)
        case .move:
            tableView.reloadRows(at: [indexPath!], with: .top)
        default:
            fatalError("feature not yet implemented")
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

        let indexSet = IndexSet(integer: sectionIndex)

        switch type {

        case .insert:
            tableView.insertSections(indexSet, with: .top)
        case .delete:
            tableView.deleteSections(indexSet, with: .top)
        case .update, .move:
            fatalError("Invalid change.")
        default:
            fatalError("feature not yet implemented")
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

        tableView.endUpdates()
    }
}
