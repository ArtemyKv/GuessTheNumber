//
//  RoundOneNumberSelectPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 16.01.2023.
//

protocol RoundOneNumberSelectViewProtocol: AnyObject {
    func numberChecked(isValid: Bool)
}

protocol RoundOneNumberSelectPresenterProtocol: AnyObject, NumberPickerPresenterProtocol, GameRestartingPresenter {
    init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinatorProtocol, game: Game)
    
    func startRoundOne(userNumber: Int)
}

class RoundOneNumberSelectPresenter: RoundOneNumberSelectPresenterProtocol {
    weak var view: RoundOneNumberSelectViewProtocol!
    
    var coordinator: MainCoordinatorProtocol!
    var game: Game!
    
    required init(view: RoundOneNumberSelectViewProtocol, coordinator: MainCoordinatorProtocol, game: Game) {
        self.view = view
        self.coordinator = coordinator
        self.game = game
    }
    
    
    func checkNumber(with numberString: String) {
        if numberIsValidWith(numberString) {
            view.numberChecked(isValid: true)
        } else {
            view.numberChecked(isValid: false)
        }
    }
    
    func startRoundOne(userNumber: Int) {
        game.setUserNumber(userNumber)
        coordinator.showRoundOneGuessScreen()
    }
    
}

