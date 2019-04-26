//
//  HomepageViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/7/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit

public class HomepageViewController: UIViewController {
    
    private enum Constants {
        static let cellReuseIdentifier = "HomepageCollectionViewCell"
        static let logoCellReuseIdentifier = "HomepageLogoCell"
        static let CellTitles = ["", "Near Me", "Our Cities", "Contact Us", "Resources", "Donate"]
        static let cellHeight: CGFloat = 100
        static let webSiteUrl = "https://www.gofundme.com/homelessnomoreapp"
    }
    
    @IBOutlet weak var navigationCollectionView: UICollectionView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureSubviews()
        title = "Home"
        let layout = navigationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: navigationCollectionView.frame.width, height: Constants.cellHeight)
    }
}

// MARK: - UICollectionViewDelegate
extension HomepageViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            return
        case 1:
            let viewController = MapViewController()
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true)
        case 2:
            let viewController = CitiesViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = ContactViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case 4:
            let viewController = ResourcesViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case 5:
            if let url = URL(string: "https://www.gofundme.com/homelessnomoreapp") {
                openUrl(url: url)
            } else {
                let alert = UIAlertController(title: "Could not load page", message: "Please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        default: //This really shouldn't happen
            let alert = UIAlertController(title: "Could not load page", message: "Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - UICollectionViewDatasource
extension HomepageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.CellTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            return logoCell(collectionView, cellForItemAt: indexPath)
        default:
            return defaultCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: Constants.cellHeight)
    }
    
    private func logoCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.logoCellReuseIdentifier, for: indexPath) as? HomepageLogoCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    private func defaultCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as? HomepageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = HomepageCollectionViewCell.ViewModel(title: Constants.CellTitles[indexPath.row])
        cell.apply(viewModel: viewModel)
        return cell
    }
}

// MARK: - Private
private extension HomepageViewController {
    func registerCells() {
        navigationCollectionView.register(HomepageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
        navigationCollectionView.register(HomepageLogoCell.self, forCellWithReuseIdentifier: Constants.logoCellReuseIdentifier)
    }
    
    func configureSubviews() {
        view.backgroundColor = Colors.backgroundColor
        navigationCollectionView.backgroundColor = .clear
        navigationCollectionView.alwaysBounceVertical = true
        navigationCollectionView.delaysContentTouches = false
        navigationCollectionView.dataSource = self
        navigationCollectionView.delegate = self
    }
}
