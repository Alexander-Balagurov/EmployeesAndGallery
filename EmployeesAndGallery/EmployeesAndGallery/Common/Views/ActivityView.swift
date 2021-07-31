//
//  ActivityView.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class ActivityView: UIView {

    private lazy var activityView: UIActivityIndicatorView = .init(style: .large)

    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                activityView.startAnimating()
            } else {
                activityView.stopAnimating()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        setupActivityIndicator()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension ActivityView {

    func setupActivityIndicator() {

        activityView.color = .white
        activityView.translatesAutoresizingMaskIntoConstraints = false

        translatesAutoresizingMaskIntoConstraints = false

        activityView.layout(in: self) {
            $0.centerX == safeAreaLayoutGuide.centerXAnchor
            $0.centerY == safeAreaLayoutGuide.centerYAnchor
        }
    }
}
