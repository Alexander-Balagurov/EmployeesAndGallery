//
//  GalleryViewCell.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 01.08.2021.
//

import UIKit

final class GalleryViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

	var image: UIImage? {
		didSet {
            imageView.image = image
		}
	}
}
