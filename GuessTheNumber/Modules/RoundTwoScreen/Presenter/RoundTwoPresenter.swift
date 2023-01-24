//
//  RoundTwoPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 18.01.2023.
//

import Foundation

protocol RoundTwoViewProtocol: AnyObject {
    func setGameInfo(tryInfo: String, guessInfo: String)
    func numberChecked(isValid: Bool)
    func presentAlert(title: String, message: String)
}

protocol RoundTwoPresenterProtocol: AnyObject, NumberPickerPresenterProtocol, GameRestartingPresenter {
    
    init(view: RoundTwoViewProtocol, coordinator: MainCoordinatorProtocol, game: Game)
    
    func startRound()
    func guessButtonPressed(proposedNumber: Int)
    func endGame()
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
    
    func checkNumber(with numberString: String) {
        if numberIsValidWith(numberString) {
            view.numberChecked(isValid: true)
        } else {
            view.numberChecked(isValid: false)
        }
        
    }
    
    func endGame() {
        coordinator.popToStartScreen()
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
                game.endGame()
            case .greater:
                guessMessage = " My number is greater than that"
        }
        view.setGameInfo(tryInfo: tryMessage, guessInfo: guessMessage)
    }
    
    func gameWinner(_ winner: Game.Winner, userTries: Int, computerTries: Int) {
        switch winner {
            case .user:
                view.presentAlert(title: "You won the game!", message: "Your tries: \(userTries)\nComputerTries: \(computerTries)")
            case .computer:
                view.presentAlert(title: "Computer won the game!", message: "Your tries: \(userTries)\nComputerTries: \(computerTries)")
            case .draw:
                view.presentAlert(title: "Draw!", message: "Nobody won the game with \(userTries) tries")
        }
    }
    
    
}
