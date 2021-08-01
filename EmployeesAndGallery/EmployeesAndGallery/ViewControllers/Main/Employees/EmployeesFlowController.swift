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
    private let persistentContainer: PersistentContainer = .init()

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

        let vc = EmployeesViewController(persistentContainer: persistentContainer)
        vc.resultActionHandler = { [weak self] in
            
            self?.handleAddAction()
        }

        return vc
    }

    //MARK: - Action Handlers
    func handleAddAction() {
        let context = persistentContainer.newChildOfViewContext()
        let vc = AddEmployeeViewController(baseEmployee: Employee(context: context), context: context)
        vc.resultActionHandler = { [weak self] in

            context.saveChangesIfNeed()
            self?.persistentContainer.viewContext.saveChangesIfNeed()
            self?.navVC.popViewController(animated: true)
        }
        navVC.pushViewController(vc, animated: true)
    }
}

