//
//  ListingCollectionViewHeaderCell.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 12/2/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class ListingCollectionViewHeaderCell: MDCCardCollectionCell {
    private enum Constants {
        static let spacing: CGFloat = 8.0
        static let rightChevron = "right-chevron"
    }
    
    struct ViewModel {
        var title: String
    }
    
    private let contentStackView = UIStackView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let chevronView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage.init(imageLiteralResourceName: Constants.rightChevron)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
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
        let size = systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height + Constants.spacing * 2)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}

// MARK - Private
extension ListingCollectionViewHeaderCell {
    func configureSubviews() {
        titleLabel.baselineAdjustment = .alignCenters
        contentStackView.axis = .horizontal
        contentStackView.spacing = Constants.spacing * 2
        
        addSubview(contentStackView)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32.0)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(chevronView)

        applyTableCellStyle()
    }
    
    func configureLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronView.widthAnchor.constraint(equalToConstant: 15),
            chevronView.heightAnchor.constraint(equalToConstant: 24),
            
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.spacing),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.spacing),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.spacing),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.spacing)
        ])
    }
}
