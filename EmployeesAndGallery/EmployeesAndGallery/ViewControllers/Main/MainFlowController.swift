//
//  MainFlowController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class MainFlowController: BaseViewController {

    // MARK: - Public

    func start() {

        addChildController(tabBarVC, to: view)
        configureTabBarController()
    }

    // MARK: - Private

    private let tabBarVC: UITabBarController = .init()
    private lazy var employeesFC: EmployeesFlowController = createEmployeesFlowController()
    private lazy var galleryNC: UINavigationController = createGalleryNavigationController()
}

fileprivate extension MainFlowController {
    func configureTabBarController() {

        tabBarVC.setViewControllers([employeesFC, galleryNC], animated: false)
    }

    func createEmployeesFlowController() -> EmployeesFlowController {

        let fc = EmployeesFlowController()
        fc.tabBarItem = UITabBarItem(
            title: R.string.localizable.list(),
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )

        return fc
    }

    func createGalleryNavigationController() -> UINavigationController {

        let nc = UINavigationController()
        let vc = GalleryViewController()
        vc.tabBarItem = UITabBarItem(
            title: R.string.localizable.gallery(),
            image: UIImage(systemName: "photo"),
            selectedImage: UIImage(systemName: "photo.fill")
        )
        nc.setViewControllers([vc], animated: false)

        return nc
    }
}
