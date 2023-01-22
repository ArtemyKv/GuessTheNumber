//
//  GameRestartProtocol.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 21.01.2023.
//

import Foundation
import UIKit

protocol GameRestartingPresenter {
    var coordinator: MainCoordinatorProtocol! { get set }
    var game: Game! { get set }
}

extension GameRestartingPresenter {
    func restartGame() {
        coordinator.popToStartScreen()
        game.resetGame()
    }
}

@objc protocol GameRestartingView {
    func restartButtonPressed()
}

extension GameRestartingView where Self: UIViewController {
    func addRestartButton() {
        let restartButton = UIBarButtonItem(title: "Restart Game", image: nil, target: self, action: #selector(restartButtonPressed))
        restartButton.tintColor = .black
        navigationItem.rightBarButtonItem = restartButton
    }
    
    func hideBackButton() {
        navigationItem.hidesBackButton = true
    }
}
