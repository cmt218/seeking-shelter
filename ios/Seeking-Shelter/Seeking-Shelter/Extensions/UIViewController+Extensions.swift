//
//  UIViewController+Extensions.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 2/12/19.
//  Copyright © 2019 Ferguson Watkins. All rights reserved.
//

import UIKit

extension UIViewController {
    func openUrl(url: URL) {
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
