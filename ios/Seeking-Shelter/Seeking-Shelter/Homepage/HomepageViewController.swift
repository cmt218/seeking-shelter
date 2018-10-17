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
        static let cellResuseIdentifier = "HomepageCollectionViewCell"
        static let CellTitles = ["Map", "Listings", "Donate", "Contact"]
        static let cellHeight: CGFloat = 100
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        configureSubviews()
        configureLayout()
        let layout = navigationCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: navigationCollectionView.frame.width, height: Constants.cellHeight)
    }
    
    @IBOutlet weak var navigationCollectionView: UICollectionView!
}

// MARK : Private
private extension HomepageViewController {
    func registerCells() {
        navigationCollectionView.register(HomepageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellResuseIdentifier)
    }
    
    func configureSubviews() {
        view.backgroundColor = .gray
        navigationCollectionView.backgroundColor = .clear
        navigationCollectionView.alwaysBounceVertical = true
        navigationCollectionView.delaysContentTouches = false
        navigationCollectionView.dataSource = self
        navigationCollectionView.delegate = self
    }
    
    func configureLayout() {
        
    }
    
}

// MARK : UICollectionViewDelegate
extension HomepageViewController: UICollectionViewDelegate {
    
}

// MARK : UICollectionViewDatasource
extension HomepageViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.CellTitles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellResuseIdentifier, for: indexPath) as? HomepageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let viewModel = HomepageCollectionViewCell.ViewModel(title: Constants.CellTitles[indexPath.row])
        cell.apply(viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: Constants.cellHeight)
    }
}
