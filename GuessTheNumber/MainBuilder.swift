//
//  MainBuilder.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 14.01.2023.
//

import UIKit

protocol Builder: AnyObject {
    func startScreen(coordinator: MainCoordinator) -> UIViewController
    func roundOneNumberSelectScreen(coordinator: MainCoordinator) -> UIViewController
    func roundOneGuessScreen(coordinator: MainCoordinator) -> UIViewController
}

class MainBuilder: Builder {
    let game = Game(minNumber: 1, maxNumber: 100)
    
    func startScreen(coordinator: MainCoordinator) -> UIViewController {
        let startViewController = StartViewController()
        let startPresenter = StartPresenter(view: startViewController, coordinator: coordinator)
        startViewController.presenter = startPresenter
        return startViewController
    }
    
    func roundOneNumberSelectScreen(coordinator: MainCoordinator) -> UIViewController {
        let roundOneNumberSelectVC = RoundOneNumberSelectViewController()
        let roundOneNumberSelectPresenter = RoundOneNumberSelectPresenter(view: roundOneNumberSelectVC, coordinator: coordinator, game: game)
        roundOneNumberSelectVC.presenter = roundOneNumberSelectPresenter
        return roundOneNumberSelectVC
    }
    
    func roundOneGuessScreen(coordinator: MainCoordinator) -> UIViewController {
        let roundOneGuessVC = RoundOneGuessViewController()
        let roundOneGuessPresenter = RoundOneGuessPresenter(view: roundOneGuessVC, coordinator: coordinator, game: game)
        roundOneGuessVC.presenter = roundOneGuessPresenter
        return roundOneGuessVC
    }
    
}
