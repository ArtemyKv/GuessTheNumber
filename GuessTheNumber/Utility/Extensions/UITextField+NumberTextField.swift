//
//  NumberTextField.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 23.01.2023.
//

import UIKit

extension UITextField {
    static func makeNumberTextField() -> UITextField {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 44, weight: .medium)
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor.backgroundColor
        textField.layer.borderWidth = 5
        textField.layer.borderColor = UIColor.borderColor.cgColor
        textField.layer.cornerRadius = 32
        return textField
    }
}
