//
//  RoundTwoView.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 18.01.2023.
//

import UIKit
import SnapKit

protocol RoundTwoViewDelegate: AnyObject {
    func guessButtonPressed()
}

class RoundTwoView: UIView {
    
    weak var delegate: RoundTwoViewDelegate?
    
    let roundTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let triesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
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

    let guessButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xACE399)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray3, for: .disabled)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let guessLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    let computerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.orange.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        
        roundTitleLabel.text = "Round Two"
        guessButton.setTitle("Guess", for: .normal)
        triesLabel.text = "Try #1"
        guessLabel.text = "Try to guess my number!"
        
        guessButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        guessButtonIsEnabled(false)
        
        setupTextfield()
        
        addSubview(roundTitleLabel)
        addSubview(triesLabel)
        addSubview(numberTextField)
        addSubview(guessButton)
        addSubview(guessLabel)
        addSubview(computerImageView)
        
        setupConstraints()
        
        
        
    }
    
    private func setupConstraints() {
        roundTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
            make.horizontalEdges.equalToSuperview()
        }
        
        triesLabel.snp.makeConstraints { make in
            make.top.equalTo(roundTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.lessThanOrEqualTo(triesLabel.snp.bottom).offset(100)
            make.top.greaterThanOrEqualTo(triesLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 100))
        }
        
        guessButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 60))
        }
        
        guessLabel.snp.makeConstraints { make in
            make.top.equalTo(guessButton.snp.bottom).offset(100).priority(.medium)
            make.size.equalTo(CGSize(width: 300, height: 50))
            make.centerX.equalToSuperview()
        }
        
        computerImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.top.equalTo(guessLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.33)
            make.height.equalTo(computerImageView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    private func setupTextfield() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        numberTextField.inputAccessoryView = toolbar
    }
    
    func guessButtonIsEnabled(_ isEnabled: Bool) {
        guessButton.isEnabled = isEnabled
        guessButton.backgroundColor = isEnabled ? UIColor(rgb: 0xACE399) : UIColor(rgb: 0xACE399, alpha: 0.3)
    }
    
    @objc private func doneButtonPressed() {
        numberTextField.endEditing(true)
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        delegate?.guessButtonPressed()
    }
}
