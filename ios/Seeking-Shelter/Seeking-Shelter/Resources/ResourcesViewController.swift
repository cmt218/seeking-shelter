//
//  ResourcesViewController.swift
//  Seeking-Shelter
//
//  Created by Cole Tomlinson on 4/15/19.
//  Copyright © 2019 Ferguson Watkins. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MDCButton

class ResourcesViewController: UIViewController {
    private enum Constants {
        static let sideInsets: CGFloat = 24
        static let spacing: CGFloat = 16
        static let callText = "Call"
        static let pageTitle = "Resources"
        static let domesticViolenceTitle = "National Domestic Violence Hotline"
        static let domesticViolenceNumber = "1-800-799-7233"
        static let sexualAbuseTitle = "National Sexual Assault Hotline"
        static let sexualAbuseNumber = "1-800-656-4673"
        static let childAbuseTitle = "National Child Abuse Hotline"
        static let childAbuseNumber = "1-800-422-4453"
        static let trevorSuicideTitle = "Trevor Hotline (LGBTQ Youth Suicide)"
        static let trevorSuicideNumber = "1-866-488-7386"
        static let missingChildTitle = "Missing Child Hotline"
        static let missingChildNumber = "1-800-235-3535"
        static let drugAbuseTitle = "Drug Abuse Hotline"
        static let drugAbuseNumber = "1-800-662-4357"
        static let runawayTitle = "National Runaway Hotline"
        static let runawayNumber = "1-800-621-4000"
        static let youthCrisisTitle = "Youth Crisis Hotline"
        static let youthCrisisNumber = "1-800-448-4663"
        static let suicideTitle = "National Suicide Hotline"
        static let suicideNumber = "1-800-784-2433"
        static let elderTitle = "Elder Abuse Hotline"
        static let elderNumber = "1-800-252-8966"
        static let numbers = [domesticViolenceNumber, sexualAbuseNumber, childAbuseNumber, trevorSuicideNumber, missingChildNumber, drugAbuseNumber, runawayNumber, youthCrisisNumber, suicideNumber, elderNumber]
    }
    
    private var scrollView: UIScrollView = UIScrollView(frame: .zero)
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let domesticViolenceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let domesticViolenceButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 0
        return button
    }()
    
    private let sexualAbuseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let sexualAbuseButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 1
        return button
    }()
    
    private let childAbuseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let childAbuseButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 2
        return button
    }()
    
    private let trevorSuicideLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let trevorSuicideButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 3
        return button
    }()
    
    private let missingChildLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let missingChildButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 4
        return button
    }()
    
    private let drugAbuseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let drugAbuseButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 5
        return button
    }()
    
    private let runawayLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let runawayButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 6
        return button
    }()
    
    private let youthCrisisLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let youthCrisisButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 7
        return button
    }()
    
    private let suicideLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let suicideButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 8
        return button
    }()
    
    private let elderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let elderButton: MDCRaisedButton = {
        let button = MDCRaisedButton(type: .system)
        MDCOutlinedButtonThemer.applyScheme(MDCButtonScheme(), to: button)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Constants.callText, for: .normal)
        button.tag = 9
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.spacing = Constants.spacing
        return stackView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayout()
        title = Constants.pageTitle
        domesticViolenceButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        childAbuseButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        drugAbuseButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        runawayButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        youthCrisisButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        suicideButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        elderButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        missingChildButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        trevorSuicideButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
        sexualAbuseButton.addTarget(self, action: #selector(callPhoneNumber), for: .primaryActionTriggered)
    }
}

private extension ResourcesViewController {
    
    func configureSubviews() {
        view.backgroundColor = Colors.backgroundColor
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = view.bounds.size
        scrollView.isDirectionalLockEnabled = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(domesticViolenceLabel)
        stackView.addArrangedSubview(domesticViolenceButton)
        stackView.addArrangedSubview(sexualAbuseLabel)
        stackView.addArrangedSubview(sexualAbuseButton)
        stackView.addArrangedSubview(childAbuseLabel)
        stackView.addArrangedSubview(childAbuseButton)
        stackView.addArrangedSubview(trevorSuicideLabel)
        stackView.addArrangedSubview(trevorSuicideButton)
        stackView.addArrangedSubview(missingChildLabel)
        stackView.addArrangedSubview(missingChildButton)
        stackView.addArrangedSubview(drugAbuseLabel)
        stackView.addArrangedSubview(drugAbuseButton)
        stackView.addArrangedSubview(runawayLabel)
        stackView.addArrangedSubview(runawayButton)
        stackView.addArrangedSubview(youthCrisisLabel)
        stackView.addArrangedSubview(youthCrisisButton)
        stackView.addArrangedSubview(suicideLabel)
        stackView.addArrangedSubview(suicideButton)
        stackView.addArrangedSubview(elderLabel)
        stackView.addArrangedSubview(elderButton)
        
        titleLabel.text = Constants.pageTitle
        domesticViolenceLabel.text = Constants.domesticViolenceTitle
        sexualAbuseLabel.text = Constants.sexualAbuseTitle
        childAbuseLabel.text = Constants.childAbuseTitle
        trevorSuicideLabel.text = Constants.trevorSuicideTitle
        missingChildLabel.text = Constants.missingChildTitle
        drugAbuseLabel.text = Constants.drugAbuseTitle
        runawayLabel.text = Constants.runawayTitle
        youthCrisisLabel.text = Constants.youthCrisisTitle
        suicideLabel.text = Constants.suicideTitle
        elderLabel.text = Constants.elderTitle
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
    
    @objc func callPhoneNumber(sender: UIButton) {
        let phoneNumber = Constants.numbers[sender.tag].filter{ return "0123456789".contains($0) }
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            openUrl(url: url)
        }
    }
}
