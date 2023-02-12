//
//  RoundOneGuessPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 17.01.2023.
//

protocol RoundOneGuessViewProtocol: AnyObject {
    func setGameInfo(tryInfo: String?, guessInfo: String, imageInfo: String)
    func setReminder(with message: String)
    func presentAlert(title: String?, message: String?)
}

protocol RoundOneGuessPresenterProtocol: AnyObject, GameRestartingPresenter {
    init(view: RoundOneGuessViewProtocol, coordinator: MainCoordinatorProtocol, game: Game)
    func startRound()
    func lessButtonTapped()
    func equalButtonTapped()
    func greaterButtonTapped()
    func nextRound()
}



class RoundOneGuessPresenter: RoundOneGuessPresenterProtocol {
    weak var view: RoundOneGuessViewProtocol!
    
    var coordinator: MainCoordinatorProtocol!
    var game: Game!
    
    
    required init(view: RoundOneGuessViewProtocol, coordinator: MainCoordinatorProtocol, game: Game) {
        self.view = view
        self.coordinator = coordinator
        self.game = game
        game.roundOneDelegate = self
    }
    
    func startRound() {
        let reminderText = "Reminder: your number is \(game.userNumber ?? 0)"
        view.setReminder(with: reminderText)
        game.startRound()
    }
    
    func lessButtonTapped() {
        game.userAnswering(.less)
    }
    
    func equalButtonTapped() {
        game.userAnswering(.equal)
        let title = "Round finished!"
        let message = "Computer guessed your number in \(game.computerTries) tries"
        view.presentAlert(title: title, message: message)
    }
    
    func greaterButtonTapped() {
        game.userAnswering(.greater)
    }
    
    func nextRound() {
        coordinator.showRoundTwoScreen()
    }
}

extension RoundOneGuessPresenter: RoundOneGameDelegate {
    func computerProposeNumber(_ number: Int) {
        let guessInfoText = "Your number is \(number) ?"
        let imageInfo = "computer_proposed"
        view.setGameInfo(tryInfo: nil, guessInfo: guessInfoText, imageInfo: imageInfo)
    }
    
    func computerThinks(tryNumber: Int) {
        let tryText  = "Try #\(tryNumber)"
        let guessInfoText = "Hmm...let me think!"
        let imageInfo = "computer_thinking"
        view.setGameInfo(tryInfo: tryText, guessInfo: guessInfoText, imageInfo: imageInfo)
    }
}
