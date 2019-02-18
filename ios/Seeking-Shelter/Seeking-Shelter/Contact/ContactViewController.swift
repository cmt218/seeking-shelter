//
//  ContactViewController.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 10/17/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MDCButton

class ContactViewController: UIViewController {
    private enum Constants {
        static let sideInsets: CGFloat = 24
        static let spacing: CGFloat = 16
        static let seekingShelter = "Seeking Shelter"
        static let seekingShelterUrl = "https://www.seekingshelter.net/"
        static let seekingShelterFacebook = "https://www.facebook.com/Seeking-Shelter-1802391203381676/"
        static let seekingShelterInstagram = "https://www.instagram.com/seekingshelter24/"
        static let seekingShelterEmail = "seekingshelter24@gmail.com"
        static let emailUs = "Email Us"
        static let visitWebsite = "Visit Website"
        static let visitFacebook = "Visit Facebook"
        static let visitInsta = "Visit Instagram"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.spacing
        return stackView
    }()
    
    private let urlButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let emailButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let facebookButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let instagramButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
        title = "Contact"
        urlButton.addTarget(self, action: #selector(openWebsite), for: .primaryActionTriggered)
        emailButton.addTarget(self, action: #selector(openEmail), for: .primaryActionTriggered)
        facebookButton.addTarget(self, action: #selector(openFacebook), for: .primaryActionTriggered)
        instagramButton.addTarget(self, action: #selector(openInstagram), for: .primaryActionTriggered)
    }
}

// MARK: - Private
private extension ContactViewController {
    func configureSubviews() {
        titleLabel.text = Constants.seekingShelter
        urlButton.setTitle(Constants.visitWebsite, for: .normal)
        emailButton.setTitle(Constants.emailUs, for: .normal)
        facebookButton.setTitle(Constants.visitFacebook, for: .normal)
        instagramButton.setTitle(Constants.visitInsta, for: .normal)
        view.backgroundColor = Colors.backgroundColor
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(emailButton)
        stackView.addArrangedSubview(urlButton)
        stackView.addArrangedSubview(facebookButton)
        stackView.addArrangedSubview(instagramButton)
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
    
    @objc func openWebsite() {
        let urlString = Constants.seekingShelterUrl
        if let url = URL(string: urlString) {
            openUrl(url: url)
        }
    }
    
    @objc func openEmail() {
        if let url = URL(string: "mailto:\(Constants.seekingShelterEmail)") {
            openUrl(url: url)
        }
    }
    
    @objc func openFacebook() {
        let urlString = Constants.seekingShelterFacebook
        if let url = URL(string: urlString) {
            openUrl(url: url)
        }
    }
    
    @objc func openInstagram() {
        let urlString = Constants.seekingShelterInstagram
        if let url = URL(string: urlString) {
            openUrl(url: url)
        }
    }
}
