//
//  GalleryViewController.swift
//  EmployeesAndGallery
//
//  Created by Александр Балагуров on 31.07.2021.
//

import UIKit

final class GalleryViewController: BaseViewController {

    // MARK: - Private

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var layout: UICollectionViewFlowLayout!
    @IBOutlet private weak var pageControl: UIPageControl!
    private lazy var previousButton: UIBarButtonItem = .init(
        title: R.string.localizable.back(),
        style: .plain,
        target: self,
        action: #selector(previousAction)
    )
    private lazy var nextButton: UIBarButtonItem = .init(
        title: R.string.localizable.forward(),
        style: .plain,
        target: self,
        action: #selector(nextAction)
    )

    private var images: [UIImage] = {
        var images: [UIImage] = []
        for image in 1...15 {
            images.append(UIImage(named: "\(image)")!)
        }

        return images
    }()

	private var currentPageIndex: Int? {
		didSet {
			currentPageDidChange()
		}
	}

    // MARK: - Override

	override func viewDidLoad() {
		super.viewDidLoad()

		initialSetup()
	}

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)

		layout.itemSize = size
		layout.invalidateLayout()

		coordinator.animate { (_) in
			self.collectionView.layoutIfNeeded()
		}
	}
}

// MARK: - Actions
fileprivate extension GalleryViewController {

	@objc func previousAction() {
		guard let currentIndex = collectionView.indexPathsForVisibleItems.first?.item,
			  currentIndex > 0 else { return }

		scrollToPage(currentIndex - 1)
    }

    @objc func nextAction() {
		guard let currentIndex = collectionView.indexPathsForVisibleItems.first?.item  else { return }

        scrollToPage(currentIndex + 1)
    }

	@IBAction func pageSelectedAction(_ pageControl: UIPageControl) {

		scrollToPage(pageControl.currentPage)
	}
}

// MARK: - Private
fileprivate extension GalleryViewController {

	func initialSetup() {

        setupNavigationBar()
        setupCollectionView()
		setupBottomBar()
	}

    func setupNavigationBar() {

        title = R.string.localizable.gallery()
        navigationController?.navigationBar.isTranslucent = true
		navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = nextButton
    }

    func setupCollectionView() {

		collectionView.bounces = false
		collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.registerNibForCell(GalleryViewCell.self)

		layout.sectionInsetReference = .fromContentInset
    }

	func setupBottomBar() {

		pageControl.numberOfPages = images.count
		pageControl.currentPage = 0
	}

	func currentPageDidChange() {

		let index = currentPageIndex ?? 0
		pageControl.currentPage = index
        if index != 0 {
            navigationItem.leftBarButtonItem = previousButton
        } else {
            navigationItem.leftBarButtonItem = nil
        }
	}

	func scrollToPage(_ index: Int, animated: Bool = true) {

		collectionView.scrollToItem(
			at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: animated
		)
	}
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell: GalleryViewCell = collectionView.dequeueCell(indexPath: indexPath)

        cell.image = images[indexPath.item]

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return view.frame.size
	}

	func collectionView(
		_ collectionView: UICollectionView,
		didEndDisplaying cell: UICollectionViewCell,
		forItemAt indexPath: IndexPath
	) {
		currentPageIndex = collectionView.indexPathsForVisibleItems.first?.item ?? 0
	}

	func collectionView(
		_ collectionView: UICollectionView,
		targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint
	) -> CGPoint {

		guard let index = currentPageIndex else {
			return .zero
		}

		let currentPageOffset = layout.itemSize.width * CGFloat(index)

		return CGPoint(x: currentPageOffset, y: 0)
	}
}
