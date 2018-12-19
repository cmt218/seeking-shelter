//
//  HomepageCollectionViewCell.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/16/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class HomepageCollectionViewCell: MDCCardCollectionCell {
    private enum Constants {
        static let spacing: CGFloat = 8.0
    }
    
    struct ViewModel {
        var title: String
    }
    
    private let contentStackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubviews()
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(viewModel: ViewModel) {
        titleLabel.text = viewModel.title
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height + Constants.spacing * 2)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}

// MARK - Private
extension HomepageCollectionViewCell {
    func configureSubviews() {
        titleLabel.baselineAdjustment = .alignCenters
        contentStackView.axis = .horizontal
        contentStackView.spacing = Constants.spacing * 2
        
        contentView.addSubview(contentStackView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 64.0)
        contentStackView.addArrangedSubview(titleLabel)
        
        applyTableCellStyle()
    }
    
    func configureLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing),
        ])
    }
}
