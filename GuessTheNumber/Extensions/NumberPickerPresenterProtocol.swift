//
//  NumberPickerPresenterProtocol.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 19.01.2023.
//

import Foundation

protocol NumberPickerPresenterProtocol: AnyObject {
    func checkNumber(with numberString: String)
}

extension NumberPickerPresenterProtocol {
    func textFieldRepalcementStringIsValid(currentText text: String, replacementString  string: String) -> Bool {
        let numbersList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        if text.count < 3 && numbersList.contains(string) || string.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func numberIsValidWith(_ numberString: String) -> Bool {
        guard let number = Int(numberString) else { return false }
        return (number > 0 && number <= 100)
    }
    
}
