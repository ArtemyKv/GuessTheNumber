//
//  RoundOneNumberSelectView.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 16.01.2023.
//

import UIKit
import SnapKit

protocol RoundOneNumberSelectViewDelegate: AnyObject {
    func startRoundButtonPressed()
}

class RoundOneNumberSelectView: UIView {
    
    weak var delegate: RoundOneNumberSelectViewDelegate?
    
    let roundTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 44, weight: .medium)
        textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        textField.backgroundColor = UIColor(rgb: 0xD9D9D9)
        textField.layer.borderWidth = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 32
        return textField
    }()
    
    let startRoundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xACE399)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray3, for: .disabled)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        backgroundColor = UIColor(rgb: 0xF6F1D3)
        
        roundTitleLabel.text = "RoundOne"
        tipLabel.text = "Pick the number in range of 1...100 and let \ncomputer guess it"
        startRoundButton.setTitle("I am ready. Let's go!", for: .normal)
        
        addSubview(roundTitleLabel)
        addSubview(tipLabel)
        addSubview(numberTextField)
        addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        startRoundButtonIsEnabled(false)
        
        setupTextField()
        
        roundTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(50)
            make.horizontalEdges.equalToSuperview()
        }
        
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(roundTitleLabel.snp.bottom).offset(44)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        numberTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 100))
        }
        
        startRoundButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(100)
            make.height.equalTo(60)
        }
    }
    
    private func setupTextField() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        numberTextField.inputAccessoryView = toolbar
    }
    
    func startRoundButtonIsEnabled(_ isEnabled: Bool) {
        startRoundButton.isEnabled = isEnabled
        startRoundButton.backgroundColor = isEnabled ? UIColor(rgb: 0xACE399) : UIColor(rgb: 0xACE399, alpha: 0.3)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.startRoundButtonPressed()
    }
    
    @objc func doneButtonPressed() {
        numberTextField.endEditing(true)
    }
}
