//
//	UITableView+reusable.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ type: T.Type) {

        register(type, forCellReuseIdentifier: String(describing: type))
    }
	
	func registerNibForCell<T: UITableViewCell>(_ type: T.Type) {

		let nib = UINib(nibName: String(describing: type), bundle: nil)
		register(nib, forCellReuseIdentifier: String(describing: type))
	}

	func register<T: UITableViewHeaderFooterView>(_ type: T.Type) {

		register(type, forHeaderFooterViewReuseIdentifier: String(describing: type))
	}
	
	func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {

		let identifier = String(describing: T.self)
		guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with \(identifier)")
		}
		return cell
	}
	
	func indexPathForRow(with view: UIView) -> IndexPath? {

		let point = self.convert(CGPoint.zero, from: view)
		return self.indexPathForRow(at: point)
	}
}
