//
//  MainCoordinator.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 14.01.2023.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func showRoundOneFirstScreen()
    func showRoundOneGuessScreen()
    func showRoundTwoScreen()
    func popToStartScreen()
}

class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var builder: Builder
    
    
    init(navigationController: UINavigationController, builder: Builder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let startVC = builder.startScreen(coordinator: self)
        navigationController.pushViewController(startVC, animated: false)
    }
    
    func showRoundOneFirstScreen() {
        let roundOneNumberSelectVC = builder.roundOneNumberSelectScreen(coordinator: self)
        navigationController.pushViewController(roundOneNumberSelectVC, animated: true)
    }
    
    func showRoundOneGuessScreen() {
        let roundOneGuessVC = builder.roundOneGuessScreen(coordinator: self)
        navigationController.pushViewController(roundOneGuessVC, animated: true)
    }
    
    func showRoundTwoScreen() {
        let roundTwoVC = builder.roundTwoScreen(coordinator: self)
        navigationController.pushViewController(roundTwoVC, animated: true)
    }
    
    func popToStartScreen() {
        navigationController.popToRootViewController(animated: true)
    }
}
