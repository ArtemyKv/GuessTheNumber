//
//  StartPresenter.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 12.01.2023.
//

import UIKit

protocol StartViewProtocol: AnyObject {
    func presentAlert(title: String?, messasge: String?)
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
        let title = "Game rules"
        let message = "Game lasts two rounds. In first round you pick a number in a range 1...100 and computer should guess it. You have to tell him whether his proposed number is lower or greater than yours or if he guessed it. In second round computer picks number and you try to guess it. Winner is the person with less tries count."
        view.presentAlert(title: title, messasge: message)
        
    }
    
    
}
