//
//  UIStyles.swift
//  Seeking-Shelter
//
//  Created by Ferguson Watkins on 12/18/18.
//  Copyright © 2018 Ferguson Watkins. All rights reserved.
//

import MaterialComponents

extension MDCCardCollectionCell {
    func applyTableCellStyle() {
        cornerRadius = 4
        setShadowElevation(ShadowElevation(rawValue: 6), for: .selected)
        setShadowColor(Colors.cardShadowColor, for: .normal)
    }
}
