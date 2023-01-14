//
//  StartPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 12.01.2023.
//

import UIKit

protocol StartViewProtocol: AnyObject {
    func presentRulesView()
}

protocol StartPresenterProtocol: AnyObject {
    init(view: StartViewProtocol, coordinator: MainCoordinator)
    
    func startGame()
    
    func showRules()
}

class StartPresenter: StartPresenterProtocol {
    weak var view: StartViewProtocol! // maybe "?"
    weak var coordinator: MainCoordinator! // maybe "?"
    
    required init(view: StartViewProtocol, coordinator: MainCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func startGame() {
        //TODO: - Implement with round one screen
    }
    
    func showRules() {
        //TODO: - Implement
    }
    
    
}
