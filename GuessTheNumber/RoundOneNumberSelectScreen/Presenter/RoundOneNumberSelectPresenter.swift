//
//  RoundOneNumberSelectPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 16.01.2023.
//

protocol RoundOneNumberSelectViewProtocol: AnyObject {
    func numberPicked(isValid: Bool)
}

protocol RoundOneNumberSelectPresenterProtocol: AnyObject {
    init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinator)
    
    func textFieldRepalcementStringIsValid(currentText text: String, replacementString string: String) -> Bool
    
    func numberPicked(with numberString: String)
    
    func startRoundOne()
}

class RoundOneNumberSelectPresenter: RoundOneNumberSelectPresenterProtocol {
    weak var view: RoundOneNumberSelectViewProtocol!
    weak var coordinator: MainCoordinator!
    
    required init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func textFieldRepalcementStringIsValid(currentText text: String, replacementString  string: String) -> Bool {
        let numbersList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        if text.count < 3 && numbersList.contains(string) || string.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func numberPicked(with numberString: String) {
        if isNumberValid(numberString: numberString) {
            view.numberPicked(isValid: true)
        } else {
            view.numberPicked(isValid: false)
        }
    }
    
    private func isNumberValid(numberString: String) -> Bool {
        guard let number = Int(numberString) else { return false }
        return (number > 0 && number <= 100)
    }
    
    func startRoundOne() {
        //TODO: - implement method
    }
    
}

