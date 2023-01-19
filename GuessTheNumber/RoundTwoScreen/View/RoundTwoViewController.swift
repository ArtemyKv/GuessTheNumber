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
    }
    
    override func loadView() {
        let roundTwoView = RoundTwoView()
        self.view = roundTwoView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RoundTwoViewController: RoundTwoViewProtocol {
    
    func setGameInfo(tryInfo: String, guessInfo: String) {
        roundTwoView.triesLabel.text = tryInfo
        roundTwoView.guessLabel.text = guessInfo
    }
    
    func numberPicked(isValid: Bool) {
        roundTwoView.guessButtonIsEnabled(isValid)
    }
}

extension RoundTwoViewController: RoundTwoViewDelegate {
    func guessButtonPressed() {
        guard
            let numberText = roundTwoView.numberTextField.text,
            let proposedNumber = Int(numberText)
        else { return }
        presenter.guessButtonPressed(proposedNumber: proposedNumber)
    }
}

extension RoundTwoViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return presenter.textFieldRepalcementStringIsValid(currentText: text, replacementString: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter.numberPicked(with: text)
    }
    
}
