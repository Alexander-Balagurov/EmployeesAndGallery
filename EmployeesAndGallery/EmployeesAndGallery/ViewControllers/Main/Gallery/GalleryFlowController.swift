//
//  GalleryFlowController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class GalleryFlowController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.gallery()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
