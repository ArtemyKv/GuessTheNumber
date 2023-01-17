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
}

class MainBuilder: Builder {
    func startScreen(coordinator: MainCoordinator) -> UIViewController {
        let startViewController = StartViewController()
        let startPresenter = StartPresenter(view: startViewController, coordinator: coordinator)
        startViewController.presenter = startPresenter
        return startViewController
    }
    
    func roundOneNumberSelectScreen(coordinator: MainCoordinator) -> UIViewController {
        let roundOneNumberSelectVC = RoundOneNumberSelectViewController()
        let roundOneNumberSelectPresenter = RoundOneNumberSelectPresenter(view: roundOneNumberSelectVC, coordinator: coordinator)
        roundOneNumberSelectVC.presenter = roundOneNumberSelectPresenter
        return roundOneNumberSelectVC
    }
    
}
