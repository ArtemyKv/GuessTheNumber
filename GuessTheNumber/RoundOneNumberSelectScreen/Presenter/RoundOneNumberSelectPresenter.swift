//
//  RoundOneNumberSelectPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 16.01.2023.
//

protocol RoundOneNumberSelectViewProtocol: AnyObject {
    func numberPicked(isValid: Bool)
}

protocol RoundOneNumberSelectPresenterProtocol: NumberPickerPresenterProtocol, AnyObject {
    init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinator, game: Game)
    
    func startRoundOne()
}

class RoundOneNumberSelectPresenter: RoundOneNumberSelectPresenterProtocol {
    weak var view: RoundOneNumberSelectViewProtocol!
    
    var coordinator: MainCoordinator!
    var game: Game!
    
    required init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinator, game: Game) {
        self.view = view
        self.coordinator = coordinator
        self.game = game
    }
    
    
    func numberPicked(with numberString: String) {
        if let number = Int(numberString), isNumberValid(numberString: numberString) {
            game.setUserNumber(number)
            view.numberPicked(isValid: true)
        } else {
            view.numberPicked(isValid: false)
        }
    }
    
    func startRoundOne() {
        coordinator.showRoundOneGuessScreen()
    }
    
}

