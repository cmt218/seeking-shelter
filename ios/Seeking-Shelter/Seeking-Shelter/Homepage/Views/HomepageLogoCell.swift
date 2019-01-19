//
//  HomepageLogoCell.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 1/19/19.
//  Copyright © 2019 Ferguson Watkins. All rights reserved.
//

import UIKit

class HomepageLogoCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(imageLiteralResourceName: "Logo")
        view.contentMode = .scaleAspectFill
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

}

// MARK - Private
extension HomepageLogoCell {
    func configureSubviews() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 75),
            imageView.heightAnchor.constraint(equalToConstant: 75),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

