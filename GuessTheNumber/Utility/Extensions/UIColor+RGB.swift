//
//  UIColor+RGB.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 13.01.2023.
//

import UIKit

extension UIColor {
    convenience init(rgb: UInt32, alpha: CGFloat = 1.0) {
        let red = (rgb & 0xFF0000) >> 16
        let green = (rgb & 0x00FF00) >> 8
        let blue = (rgb & 0x0000FF)
        
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
}
