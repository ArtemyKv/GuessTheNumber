//
//  RoundOneNumberSelectViewController.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 16.01.2023.
//

import UIKit

class RoundOneNumberSelectViewController: UIViewController {
    
    var presenter: RoundOneNumberSelectPresenterProtocol!
    
    var roundOneNumberSelectView: RoundOneNumberSelectView! {
        guard isViewLoaded else { return nil }
        return (view as! RoundOneNumberSelectView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundOneNumberSelectView.delegate = self
        roundOneNumberSelectView.numberTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextField.textDidChangeNotification, object: roundOneNumberSelectView.numberTextField)
    }
    
    override func loadView() {
        super.loadView()
        let view = RoundOneNumberSelectView()
        self.view = view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addRestartButton()
    }
    
    //Hides keyboard when user tap on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func textFieldTextDidChange() {
        guard let numberString = roundOneNumberSelectView.numberTextField.text else { return }
        presenter.checkNumber(with: numberString)
    }

}

extension RoundOneNumberSelectViewController: RoundOneNumberSelectViewProtocol {
    func numberChecked(isValid: Bool) {
        roundOneNumberSelectView.startRoundButtonIsEnabled(isValid)
    }
}

extension RoundOneNumberSelectViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return presenter.textFieldRepalcementStringIsValid(currentText: text, replacementString: string)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        presenter.checkNumber(with: text)
    }
}

extension RoundOneNumberSelectViewController: RoundOneNumberSelectViewDelegate {
    func startRoundButtonPressed() {
        guard let text = roundOneNumberSelectView.numberTextField.text, let number = Int(text) else { return }
        presenter.startRoundOne(userNumber: number)
    }
}

extension RoundOneNumberSelectViewController: GameRestartingView {
    func restartButtonPressed() {
        presenter.restartGame()
    }
}
