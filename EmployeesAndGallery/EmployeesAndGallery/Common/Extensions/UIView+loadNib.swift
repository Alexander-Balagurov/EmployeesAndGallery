//
//  UIView+loadNib.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

extension UIView {
    static func loadFromNib<T>() -> T {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError()
        }
        return view
    }
}
