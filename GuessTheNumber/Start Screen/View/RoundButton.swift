//
//  RoundButton.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 13.01.2023.
//

import UIKit

class RoundButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }
    
}
