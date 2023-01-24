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
        label.textColor = .textMainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .textMainColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let numberTextField = UITextField.makeNumberTextField()
    
    let startRoundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonMainColor
        button.setTitleColor(.textMainColor, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.setTitleColor(.gray, for: .highlighted)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let backgroundView = BackgroundView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        
        roundTitleLabel.text = "RoundOne"
        tipLabel.text = "Pick the number in range of 1...100 and let \ncomputer guess it"
        startRoundButton.setTitle("I am ready. Let's go!", for: .normal)
        
        addSubview(backgroundView)
        addSubview(roundTitleLabel)
        addSubview(tipLabel)
        addSubview(numberTextField)
        addSubview(startRoundButton)
        
        startRoundButton.addTarget(self, action: #selector(buttonTouchedUpInside), for: .touchUpInside)
        startRoundButton.addTarget(self, action: #selector(buttonTouchedUpOutside), for: .touchUpOutside)
        startRoundButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        startRoundButtonIsEnabled(false)
        
        setupTextField()
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        roundTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(8)
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
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
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
        startRoundButton.backgroundColor = isEnabled ? .buttonMainColor : .buttonDisabledColor
    }
    
    @objc func buttonTouchedUpInside(_ sender: UIButton) {
        sender.animateTouchUp()
        delegate?.startRoundButtonPressed()
    }
    
    @objc func buttonTouchedUpOutside(_ sender: UIButton) {
        sender.animateTouchUp()
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        sender.animateTouchDown()
    }
    
    @objc func doneButtonPressed() {
        numberTextField.endEditing(true)
    }
}
