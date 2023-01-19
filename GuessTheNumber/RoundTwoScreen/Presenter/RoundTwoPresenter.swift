//
//  RoundTwoPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 18.01.2023.
//

import Foundation

protocol RoundTwoViewProtocol: AnyObject {
    func setGameInfo(tryInfo: String, guessInfo: String)
    func numberPicked(isValid: Bool)
}

protocol RoundTwoPresenterProtocol: NumberPickerPresenterProtocol, AnyObject {
    init(view: RoundTwoViewProtocol, coordinator: MainCoordinatorProtocol, game: Game)
    
    func startRound()
    func guessButtonPressed(proposedNumber: Int)
}

class RoundTwoPresenter: RoundTwoPresenterProtocol {
    
    var view: RoundTwoViewProtocol!
    var coordinator: MainCoordinatorProtocol!
    var game: Game!
    
    required init(view: RoundTwoViewProtocol, coordinator: MainCoordinatorProtocol, game: Game) {
        self.view = view
        self.coordinator = coordinator
        self.game = game
        game.roundTwoDelegate = self
    }
    
    func startRound() {
        game.startRound()
    }
    
    func guessButtonPressed(proposedNumber: Int) {
        game.userProposeNumber(proposedNumber)
    }
    
    func numberPicked(with numberString: String) {
        if isNumberValid(numberString: numberString) {
            view.numberPicked(isValid: true)
        } else {
            view.numberPicked(isValid: false)
        }
        
    }
}

extension RoundTwoPresenter: RoundTwoGameDelegate {
    func computerAnswer(_ answer: Game.Answer, tryNumber: Int) {
        let tryMessage = "Try #\(tryNumber)"
        var guessMessage = ""
        
        switch answer {
            case .less:
                guessMessage = "My number is less than that"
            case .equal:
                guessMessage = "Yes! That's my number!"
            case .greater:
                guessMessage = " My number is greater than that"
        }
        view.setGameInfo(tryInfo: tryMessage, guessInfo: guessMessage)
    }
    
    
}
