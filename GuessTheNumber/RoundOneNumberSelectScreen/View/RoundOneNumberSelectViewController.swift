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
    }
    
    override func loadView() {
        super.loadView()
        let view = RoundOneNumberSelectView()
        self.view = view
    }
    
    //Hides keyboard when user tap on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension RoundOneNumberSelectViewController: RoundOneNumberSelectViewProtocol {
    func numberPicked(isValid: Bool) {
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
        presenter.numberPicked(with: text)
    }
}

extension RoundOneNumberSelectViewController: RoundOneNumberSelectViewDelegate {
    func startRoundButtonPressed() {
        presenter.startRoundOne()
    }
}
