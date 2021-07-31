//
//  EmployeesViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class EmployeesViewController: BaseViewController {

    // MARK: - Public

    var resultActionHandler: ((ResultAction) -> Void)?


    // MARK: - Private
    private let tableView: UITableView = .init()

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
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

