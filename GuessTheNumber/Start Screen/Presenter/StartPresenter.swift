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
    init(view: StartViewProtocol, coordinator: MainCoordinatorProtocol)
    
    func startGame()
    
    func showRules()
}

class StartPresenter: StartPresenterProtocol {
    weak var view: StartViewProtocol! // maybe "?"
    weak var coordinator: MainCoordinatorProtocol! // maybe "?"
    
    required init(view: StartViewProtocol, coordinator: MainCoordinatorProtocol) {
        self.view = view
        self.coordinator = coordinator
    }
    
    func startGame() {
        coordinator.showRoundOneFirstScreen()
    }
    
    func showRules() {
        //TODO: - Implement
    }
    
    
}
