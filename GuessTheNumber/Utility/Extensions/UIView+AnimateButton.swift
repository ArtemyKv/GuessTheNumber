//
//  UIView+AnimateButton.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 23.01.2023.
//

import UIKit

extension UIButton {
    func animateTouchDown() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    func animateTouchUp() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
}
