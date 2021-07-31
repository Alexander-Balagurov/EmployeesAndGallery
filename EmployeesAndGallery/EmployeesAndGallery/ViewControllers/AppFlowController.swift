//
//  AppFlowController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class AppFlowController: BaseViewController {

    // MARK: - Public
    func start() {

        startMainFlow()
    }

    // MARK: - Private properties
    private var onboardingNavigationController: UINavigationController?
    private var mainFlowController: MainFlowController?

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

// MARK: - Configuration
fileprivate extension AppFlowController {

    func startMainFlow() {

        let mainFC: MainFlowController = .init()
        mainFlowController = mainFC
        addChildController(mainFC, to: self.view)
        mainFC.start()
    }
}
