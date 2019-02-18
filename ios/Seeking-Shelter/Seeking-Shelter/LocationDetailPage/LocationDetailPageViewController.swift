//
//  LocationDetailPageViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 11/4/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MaterialComponents.MDCButton

final class LocationDetailPageViewController: UIViewController {
    private enum Constants {
        static let sideInsets: CGFloat = 24
        static let spacing: CGFloat = 16
        static let visitWebsite = "Visit Website"
        static let directions = "Directions"
        static let call = "Call"
    }

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let addressButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let phoneButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let urlButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.spacing
        return stackView
    }()
    
    private let location: ShelterLocation
    private var scrollView: UIScrollView = UIScrollView(frame: .zero)
    
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
        urlButton.addTarget(self, action: #selector(goToWebsite), for: .primaryActionTriggered)
        addressButton.addTarget(self, action: #selector(openMaps), for: .primaryActionTriggered)
    }
}

// MARK: - Private

private extension LocationDetailPageViewController {
    func configureSubviews() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.isDirectionalLockEnabled = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(phoneButton)
        stackView.addArrangedSubview(addressButton)
        stackView.addArrangedSubview(urlButton)
    }
    
    func configureLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideInsets),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideInsets),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.sideInsets),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.sideInsets),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
    
    func applyLocation() {
        titleLabel.text = location.organizationName
        descriptionLabel.text = location.overview
        
        if let category = location.category {
            categoryLabel.text = category.rawValue
        }

        if let _ = location.fullAddress {
            addressButton.setTitle(Constants.directions, for: .normal)
        }
        if let _ = location.website {
            urlButton.setTitle(Constants.visitWebsite, for: .normal)
        }
        if let _ = location.phoneNumber {
            phoneButton.setTitle(Constants.call, for: .normal)
        }
    }
    
    @objc func callPhoneNumber() {
        let phoneNumber = location.phoneNumber?.filter{ return "0123456789".contains($0) }
        if let url = URL(string: "tel://\(phoneNumber ?? "")"), UIApplication.shared.canOpenURL(url) {
            openUrl(url: url)
        }
    }
    
    @objc func goToWebsite() {
        guard let urlString = location.website else { return }
        if let url = URL(string: urlString) {
            openUrl(url: url)
        }
    }
    
    @objc func openMaps() {
        guard let address = location.fullAddress else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarksOptional, error) -> Void in
            if let placemarks = placemarksOptional {
                if let location = placemarks.first?.location {
                    let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
                    let path = "http://maps.apple.com/" + query
                    if let url = URL(string: path) {
                        self.openUrl(url: url)
                    }
                }
            }
        }
    }
}
