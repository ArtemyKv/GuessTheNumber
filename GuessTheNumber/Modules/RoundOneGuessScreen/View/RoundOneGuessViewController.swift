//
//  RoundOneGuessViewController.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 17.01.2023.
//

import UIKit

class RoundOneGuessViewController: UIViewController {
    
    var presenter: RoundOneGuessPresenterProtocol!
    
    var roundOneGuessView: RoundOneGuessView! {
        guard isViewLoaded else { return nil }
        return (view as! RoundOneGuessView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundOneGuessView.delegate = self
        presenter.startRound()
        
    }
    
    override func loadView() {
        super.loadView()
        let view = RoundOneGuessView()
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addRestartButton()
    }

}

extension RoundOneGuessViewController: RoundOneGuessViewProtocol {
    
    func setGameInfo(tryInfo: String?, guessInfo: String, imageInfo: String) {
        if let tryInfo {
            roundOneGuessView.triesLabel.text = tryInfo
        }
        roundOneGuessView.guessLabel.text = guessInfo
        roundOneGuessView.computerImageView.image = UIImage(named: imageInfo)
    }
    
    func setReminder(with message: String) {
        roundOneGuessView.reminderLabel.text = message
    }
    
    func presentAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default) { [weak self] _ in
            self?.presenter.nextRound()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
}

extension RoundOneGuessViewController: RoundOneGuessViewDelegate {
    func lessButtonTapped() {
        presenter.lessButtonTapped()
    }
    
    func equalButtonTapped() {
        presenter.equalButtonTapped()
    }
    
    func greaterButtonTapped() {
        presenter.greaterButtonTapped()
    }
    
    
}

extension RoundOneGuessViewController: GameRestartingView {
    func restartButtonPressed() {
        presenter.restartGame()
    }
}
