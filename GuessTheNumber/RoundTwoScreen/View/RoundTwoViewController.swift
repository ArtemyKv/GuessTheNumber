//
//  RoundTwoViewController.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 18.01.2023.
//

import UIKit

class RoundTwoViewController: UIViewController {
    
    var presenter: RoundTwoPresenterProtocol!
    
    var roundTwoView: RoundTwoView! {
        guard isViewLoaded else { return nil }
        return (view as! RoundTwoView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundTwoView.delegate = self
        roundTwoView.numberTextField.delegate = self
        presenter.startRound()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextField.textDidChangeNotification, object: roundTwoView.numberTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addRestartButton()
    }
    
    override func loadView() {
        let roundTwoView = RoundTwoView()
        self.view = roundTwoView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func textFieldTextDidChange() {
        guard let numberString = roundTwoView.numberTextField.text else { return }
        presenter.checkNumber(with: numberString)
    }
}

extension RoundTwoViewController: RoundTwoViewProtocol {
    
    func setGameInfo(tryInfo: String, guessInfo: String) {
        roundTwoView.triesLabel.text = tryInfo
        roundTwoView.guessLabel.text = guessInfo
    }
    
    func numberChecked(isValid: Bool) {
        roundTwoView.guessButtonIsEnabled(isValid)
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "End game", style: .default) { [weak self] _ in
            self?.presenter.endGame()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension RoundTwoViewController: RoundTwoViewDelegate {
    func guessButtonPressed() {
        guard
            let numberText = roundTwoView.numberTextField.text,
            let proposedNumber = Int(numberText)
        else { return }
        presenter.guessButtonPressed(proposedNumber: proposedNumber)
        view.endEditing(true)
    }
}

extension RoundTwoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return presenter.textFieldRepalcementStringIsValid(currentText: text, replacementString: string)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
}

extension RoundTwoViewController: GameRestartingView {
    func restartButtonPressed() {
        presenter.restartGame()
    }
}
