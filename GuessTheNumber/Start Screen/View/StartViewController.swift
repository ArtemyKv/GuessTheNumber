//
//  StartViewController.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 12.01.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    var presenter: StartPresenterProtocol!
    
    var startView: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startView.delegate = self

    }
    
    override func loadView() {
        let view = StartView()
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startView.animateAppearance()
    }

}

extension StartViewController: StartViewProtocol {
    func presentRulesView() {
        //TODO: - Implement
    }
}

extension StartViewController: StartViewDelegate {
    func startButtonPressed() {
        presenter.startGame()
    }
    
    func rulesButtonPressed() {
        presenter.showRules()
    }
    
    
}
