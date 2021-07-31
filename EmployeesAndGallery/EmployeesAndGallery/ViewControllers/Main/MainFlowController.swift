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
    private lazy var galleryFC: GalleryFlowController = createGalleryFlowController()

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

fileprivate extension MainFlowController {
    func configureTabBarController() {
        tabBarVC.setViewControllers([employeesFC, galleryFC], animated: false)
        tabBarVC.selectedViewController = tabBarVC.viewControllers?.first
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

    func createGalleryFlowController() -> GalleryFlowController {
        let fc = GalleryFlowController()
        fc.tabBarItem = UITabBarItem(
            title: R.string.localizable.gallery(),
            image: UIImage(systemName: "photo"),
            selectedImage: UIImage(systemName: "photo.fill")
        )

        return fc
    }
}
