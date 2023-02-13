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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startView.prepareForAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startView.animateAppearance()
    }

}

extension StartViewController: StartViewProtocol {
    func presentAlert(title: String?, messasge: String?) {
        let alert = UIAlertController(title: title, message: messasge, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
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
