//
//  MainBuilder.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 14.01.2023.
//

import UIKit

protocol Builder: AnyObject {
    func startScreen(coordinator: MainCoordinator) -> UIViewController
}

class MainBuilder: Builder {
    func startScreen(coordinator: MainCoordinator) -> UIViewController {
        let startViewController = StartViewController()
        let startPresenter = StartPresenter(view: startViewController, coordinator: coordinator)
        startViewController.presenter = startPresenter
        return startViewController
    }
    
    
}
