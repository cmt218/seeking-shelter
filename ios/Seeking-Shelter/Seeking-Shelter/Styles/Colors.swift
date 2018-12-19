//
//  Colors.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 12/18/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import UIKit
public enum Colors {
    //255, 85, 43
    static let backgroundColor = UIColor.fromRGB(red: 245, green: 245, blue: 245, alpha: 1)
    static let cardShadowColor = UIColor.fromRGB(red: 255, green: 85, blue: 43, alpha: 1)
}

extension UIColor {
    static func fromRGB(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(CGFloat(red)/255.0), green: CGFloat(CGFloat(green)/255.0), blue: CGFloat(CGFloat(blue)/255.0), alpha: alpha)
    }
}
