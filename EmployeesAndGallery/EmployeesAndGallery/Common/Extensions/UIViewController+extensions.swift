//
//  UIViewController+extensions.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

// MARK: Adding/Remove child VCs
extension UIViewController {

	func addChildController(
		_ child: UIViewController,
		to container: UIView,
		fillContainer fill: Bool = true
	) {

		addChild(child)
		container.addSubview(child.view)
		child.didMove(toParent: self)

		if fill {
			child.view.layout(in: container)
		}
	}

	func removeChild(_ child: UIViewController) {

		child.willMove(toParent: nil)
		child.view.removeFromSuperview()
		child.removeFromParent()
	}
}

// MARK: - Custom views
extension UIViewController {

	@discardableResult
	func addLoadingView() -> ActivityView {

		let v = ActivityView(frame: view.bounds)
		v.isAnimating = true
		v.layout(in: view)

		return v
	}
}
