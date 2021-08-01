//
//	UICollectionView+reusable.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ type: T.Type) {

        register(type, forCellWithReuseIdentifier: String(describing: type))
    }

    func registerNibForCell<T: UICollectionViewCell>(_ type: T.Type) {

        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: type))
    }

	func register<T: UICollectionReusableView>(_ type: T.Type, ofKind kind: String) {

		register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
	}

    func registerNibForSupplementaryView<T: UICollectionReusableView>(_ type: T.Type, ofKind kind: String) {

        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: type))
    }

    func dequeueCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {

        let identifier = String(describing: T.self)

        let bareCell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(identifier)")
        }
        return cell
    }

    func dequeueSupplementaryView<T: UICollectionReusableView>(
        of kind: String, at indexPath: IndexPath
    ) -> T {
        
        let identifier = String(describing: T.self)

        let bareView = dequeueReusableSupplementaryView(
            ofKind: kind, withReuseIdentifier: identifier, for: indexPath
        )
        guard let supplementaryView = bareView as? T else {
            fatalError("Failed to dequeue a supplementary view with identifier \(identifier)")
        }
        return supplementaryView
    }
}
