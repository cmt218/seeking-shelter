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
        static let headerReuseIdentifier = "ListingCollectionViewHeader"
        static let cellHeight: CGFloat = 30
        static let cellWidth: CGFloat = 300
    }
    
    private let collectionView: UICollectionView
    private let webService = WebService.shared
    private var locations: [ShelterLocation]?
    private var cities: [String] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        layout.headerReferenceSize = CGSize(width: 50, height: 50)
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
        title = "Listings"
        webService.getLocations { [weak self] shelterLocationList in
            guard let self = self else { return }
            self.locations = shelterLocationList.locations
            self.getCities()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: - Private

private extension ListingsViewController {
    func registerCells() {
        collectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        collectionView.register(ListingCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.headerReuseIdentifier)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
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
    
    func getCities() {
        guard let locations = locations else { return }
        locations.forEach {
            if let city = $0.city, !cities.contains(city) {
                cities.append(city)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ListingsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let locations = locations else {
            return 0
        }
        let city = cities[section]
        let count = locations.reduce(0) { sum, location in
            return location.city == city ? sum + 1 : sum
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.headerReuseIdentifier, for: indexPath) as? ListingCollectionViewHeaderCell else {
            return UICollectionReusableView()
        }
        
        let city = cities[indexPath.section].isEmpty ? "Other" : cities[indexPath.section]
        let viewModel = ListingCollectionViewHeaderCell.ViewModel(title: city)
        header.apply(viewModel: viewModel)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? ListingsCollectionViewCell else {
            return UICollectionViewCell()
        }
        let section = locations?.filter{ $0.city == cities[indexPath.section] }
        let name = section?[indexPath.item].organizationName ?? "Default name"
        let viewModel = ListingsCollectionViewCell.ViewModel(title: name)
        cell.apply(viewModel: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ListingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = locations?.filter{ $0.city == cities[indexPath.section] }
        guard let location = section?[indexPath.row] else { return }
        let locationDetailPageViewController = LocationDetailPageViewController(with: location)
        navigationController?.pushViewController(locationDetailPageViewController, animated: true)
    }
}
