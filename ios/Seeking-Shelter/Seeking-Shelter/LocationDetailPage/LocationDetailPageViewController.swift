//
//  LocationDetailPageViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 11/4/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit

final class LocationDetailPageViewController: UIViewController {
    private enum Constants {
        static let sideInsets: CGFloat = 24
        static let spacing: CGFloat = 16
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let phoneButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.spacing
        return stackView
    }()
    
    private let location: ShelterLocation
    
    init(with location: ShelterLocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
        applyLocation()
        view.backgroundColor = Colors.backgroundColor
        title = location.organizationName
        phoneButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
    }
    
}

// MARK: - Private

private extension LocationDetailPageViewController {
    func configureSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(phoneButton)
        stackView.addArrangedSubview(descriptionLabel)
    }
    
    func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideInsets),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideInsets)
        ])
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.sideInsets)
            ])
        } else {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: Constants.sideInsets)
            ])
        }
    }
    
    func applyLocation() {
        titleLabel.text = location.organizationName
        addressLabel.text = location.fullAddress
        descriptionLabel.text = location.overview
        if let phoneNumber = location.phoneNumber {
            let attributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
                NSAttributedString.Key.foregroundColor : UIColor.blue,
                NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
                ] as [NSAttributedString.Key : Any]
            let phoneNumber = NSAttributedString(string: phoneNumber, attributes: attributes)
            phoneButton.setAttributedTitle(phoneNumber, for: .normal)
        }
    }
    
    @objc func callPhoneNumber() {
        let phoneNumber = location.phoneNumber?.filter{ return "0123456789".contains($0) }
        if let url = URL(string: "tel://\(phoneNumber ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
