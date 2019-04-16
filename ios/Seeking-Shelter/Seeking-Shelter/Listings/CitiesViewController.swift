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

class CitiesViewController: UIViewController {
    
    private enum Constants {
        static let headerReuseIdentifier = "ListingCollectionViewHeader"
        static let cellHeight: CGFloat = 30
        static let cellWidth: CGFloat = 300
        static let collectionViewInset = UIEdgeInsets(top: 16, left: 8, bottom: 0, right: -8)
    }
    
    private let collectionView: UICollectionView
    private let webService = WebService.shared
    private var locations: [ShelterLocation]?
    private var cities: [String] = []
    
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
        title = "Cities"
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

private extension CitiesViewController {
    func registerCells() {
        collectionView.register(ListingCollectionViewHeaderCell.self, forCellWithReuseIdentifier: Constants.headerReuseIdentifier)
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
    
    func getCities() {
        guard let locations = locations else { return }
        locations.forEach {
            if let city = $0.city, !cities.contains(city) {
                cities.append(city)
            }
        }
        cities.sort()
    }
    
}

// MARK: - UICollectionViewDataSource
extension CitiesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.headerReuseIdentifier, for: indexPath) as? ListingCollectionViewHeaderCell else {
            return UICollectionViewCell()
        }
        let name = cities[indexPath.item]
        let viewModel = ListingCollectionViewHeaderCell.ViewModel(title: name)
        cell.apply(viewModel: viewModel)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension CitiesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let city = cities[indexPath.item]
        let cityLocations = locations?.filter{ $0.city == cities[indexPath.item] }
        let listingsViewController = ListingsViewController(city: city, locations: cityLocations)
        
        navigationController?.pushViewController(listingsViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - Constants.collectionViewInset.left * 2, height: 20)
    }
}
