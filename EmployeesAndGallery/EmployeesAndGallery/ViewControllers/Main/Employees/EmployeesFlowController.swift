//
//  EmployeesFlowController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class EmployeesFlowController: BaseViewController {

    // MARK: - Private
    private lazy var employeesVC: EmployeesViewController = createEmployeesViewController()
    private let navVC: UINavigationController = .init()

    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
}

fileprivate extension EmployeesFlowController {
    func initialSetup() {

        addChildController(navVC, to: view)
        navVC.setViewControllers([employeesVC], animated: false)
        navVC.navigationBar.prefersLargeTitles = true
    }

    func createEmployeesViewController() -> EmployeesViewController {

        let vc = EmployeesViewController()
        vc.resultActionHandler = { [weak self] action in
            switch action {

            case .edit:
                self?.handleEditAction()
            case .add:
                self?.handleAddAction()
            }
        }

        return vc
    }

    //MARK: - Action Handlers

    func handleEditAction() {

    }

    func handleAddAction() {
        let vc = AddEmployeeViewController(baseEmployee: Employee(), context: nil)
        navVC.pushViewController(vc, animated: true)
    }
}

