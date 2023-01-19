//
//  MainBuilder.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 14.01.2023.
//

import UIKit

protocol Builder: AnyObject {
    func startScreen(coordinator: MainCoordinatorProtocol) -> UIViewController
    func roundOneNumberSelectScreen(coordinator: MainCoordinatorProtocol) -> UIViewController
    func roundOneGuessScreen(coordinator: MainCoordinatorProtocol) -> UIViewController
    func roundTwoScreen(coordinator: MainCoordinatorProtocol) -> UIViewController
}

class MainBuilder: Builder {
    let game = Game(minNumber: 1, maxNumber: 100)
    
    func startScreen(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let startViewController = StartViewController()
        let startPresenter = StartPresenter(view: startViewController, coordinator: coordinator)
        startViewController.presenter = startPresenter
        return startViewController
    }
    
    func roundOneNumberSelectScreen(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let roundOneNumberSelectVC = RoundOneNumberSelectViewController()
        let roundOneNumberSelectPresenter = RoundOneNumberSelectPresenter(view: roundOneNumberSelectVC, coordinator: coordinator, game: game)
        roundOneNumberSelectVC.presenter = roundOneNumberSelectPresenter
        return roundOneNumberSelectVC
    }
    
    func roundOneGuessScreen(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let roundOneGuessVC = RoundOneGuessViewController()
        let roundOneGuessPresenter = RoundOneGuessPresenter(view: roundOneGuessVC, coordinator: coordinator, game: game)
        roundOneGuessVC.presenter = roundOneGuessPresenter
        return roundOneGuessVC
    }
    
    func roundTwoScreen(coordinator: MainCoordinatorProtocol) -> UIViewController {
        let roundTwoVC = RoundTwoViewController()
        let roundTwoPresenter = RoundTwoPresenter(view: roundTwoVC, coordinator: coordinator, game: game)
        roundTwoVC.presenter = roundTwoPresenter
        return roundTwoVC
    }
    
}
