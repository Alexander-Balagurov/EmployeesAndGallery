//
//  BaseViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

class BaseViewController: UIViewController {
    deinit {
        print(#function + " - \(type(of: self))")
    }

    private(set) lazy var loadingView: ActivityView = addLoadingView()

    // MARK: - Overriden
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }

    // MARK: - Public
    func pushToNavigationController(_ vc: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }

    open func showLoadingView() {
        loadingView.isHidden = false
    }

    open func hideLoadingView() {
        loadingView.isHidden = true
    }
}
