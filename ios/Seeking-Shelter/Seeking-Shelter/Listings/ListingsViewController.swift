//
//  ListingsViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/17/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit

class ListingsViewController: UIViewController {
    
    private enum Constants {
        static let cellReuseIdentifier = "ListingsCollectionViewCell"
        static let cellHeight: CGFloat = 30
        static let cellWidth: CGFloat = 300
    }
    
    private let collectionView: UICollectionView
    private let webService = WebService()
    private var locations: [ShelterLocation]?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
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
        locations = webService.getStaticData()?.locations
        //webService.makeGetCall()
        title = "Listings"
    }
    
}

// MARK : Private

private extension ListingsViewController {
    func registerCells() {
        collectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    func configureSubviews() {
        view.backgroundColor = .gray
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

// MARK: Datasource
extension ListingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let locations = locations else {
            return 0
        }
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? ListingsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let name = locations?[indexPath.row].organizationName ?? "Default name"
        let viewModel = ListingsCollectionViewCell.ViewModel(title: name)
        cell.apply(viewModel: viewModel)
        return cell
    }
    
    
}

// MARK: Delegate
extension ListingsViewController: UICollectionViewDelegate {
    
}
