//
//  MainCoordinator.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 14.01.2023.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func showRoundOneFirstScreen()
}

class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var builder: MainBuilder
    
    
    init(navigationController: UINavigationController, builder: MainBuilder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func start() {
        let startVC = builder.startScreen(coordinator: self)
        navigationController.pushViewController(startVC, animated: false)
    }
    
    func showRoundOneFirstScreen() {
        //TODO: - Implement with round one screen
    }
}
