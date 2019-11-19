
//
//  UIColor+Hex.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: UInt, alphaVal: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hexString & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexString & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexString & 0x0000FF) / 255.0,
            alpha: alphaVal
        )
    }
}
