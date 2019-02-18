//
//  ListingsViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/17/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialCards

class ListingsViewController: UIViewController {
    private enum Constants {
        static let cellReuseIdentifier = "ListingsCollectionViewCell"
        static let cellHeight: CGFloat = 30
        static let cellWidth: CGFloat = 300
        static let collectionViewInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: -8)
    }
    
    private let collectionView: UICollectionView
    private var locations: [ShelterLocation]
    private let city: String
    
    init(city: String?, locations: [ShelterLocation]?) {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.locations = (locations ?? []).filter( {$0.overview != nil && $0.overview != ""} )
        self.city = city ?? "Locations"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureSubviews()
        configureLayout()
        title = city
    }
    
}

// MARK: - Private

private extension ListingsViewController {
    func registerCells() {
        collectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    func configureSubviews() {
        view.backgroundColor = Colors.backgroundColor
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureLayout() {
        collectionView.contentInset.top = Constants.collectionViewInset.top
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.collectionViewInset.right),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.collectionViewInset.left)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension ListingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? ListingsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let name = locations[indexPath.item].organizationName ?? "Default name"
        let viewModel = ListingsCollectionViewCell.ViewModel(title: name)
        cell.apply(viewModel: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ListingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let locationDetailPageViewController = LocationDetailPageViewController(with: location)
        //let navController = UINavigationController(rootViewController: locationDetailPageViewController)
        navigationController?.pushViewController(locationDetailPageViewController, animated: true)
        //self.present(navController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - Constants.collectionViewInset.left * 2, height: 20)
    }
}
