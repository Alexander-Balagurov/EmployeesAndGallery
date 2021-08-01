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

    var resultActionHandler: ((ResultAction) -> Void)?

    // MARK: - Private
    private let tableView: UITableView = .init()
    private let persistentContainer: PersistentContainer

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let request: NSFetchRequest = BaseEmployee.fetchRequest()

        let baseEmp: [BaseEmployee] = try! persistentContainer.viewContext.fetch(request)
        print(baseEmp)
    }
}

//MARK: - Types

extension EmployeesViewController {
    enum ResultAction {
        case edit
        case add
    }
}

fileprivate extension EmployeesViewController {

    func initialSetup() {

        view.backgroundColor = .white
        configureNavigationBar()
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
        resultActionHandler?(.edit)
    }

    @objc func addButtonTapped() {
        resultActionHandler?(.add)
    }
}

