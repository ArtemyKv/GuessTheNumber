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
    
    private let wrongAnswerImages = [
        UIImage(named: "computer_wrong_ans_1"),
        UIImage(named: "computer_wrong_ans_2"),
        UIImage(named: "computer_wrong_ans_3")
    ]
    
    let roundTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .textMainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let triesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .textMainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let numberTextField = UITextField.makeNumberTextField()

    let guessButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonMainColor
        button.setTitleColor(.textMainColor, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.setTitleColor(.gray, for: .disabled)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let guessLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .textMainColor
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = UIColor.backgroundColor
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.borderColor.cgColor
        label.layer.masksToBounds = true
        return label
    }()
    
    let computerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        
        roundTitleLabel.text = "Round Two"
        guessButton.setTitle("Guess", for: .normal)
        triesLabel.text = "Try #1"
        guessLabel.text = "Try to guess my number!"
        computerImageView.image = UIImage(named: "computer_second_round")
        
        guessButton.addTarget(self, action: #selector(buttonTouchedUpInside), for: .touchUpInside)
        guessButton.addTarget(self, action: #selector(buttonTouchedUpOutside), for: .touchUpOutside)
        guessButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        guessButtonIsEnabled(false)
        
        setupTextfield()
        
        addSubview(backgroundView)
        addSubview(roundTitleLabel)
        addSubview(triesLabel)
        addSubview(numberTextField)
        addSubview(guessButton)
        addSubview(guessLabel)
        addSubview(computerImageView)
        
        setupConstraints()
        
        
        
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        roundTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
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
            make.top.lessThanOrEqualTo(numberTextField.snp.bottom).offset(60)
            make.bottom.lessThanOrEqualTo(guessLabel.snp.top).offset(-40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 60))
        }
        
        guessLabel.snp.makeConstraints { make in
            make.bottom.equalTo(computerImageView.snp.top).offset(-30)
            make.size.equalTo(CGSize(width: 300, height: 50))
            make.centerX.equalToSuperview()
        }
        
        computerImageView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.width.equalToSuperview().multipliedBy(0.4)
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
        guessButton.backgroundColor = isEnabled ? .buttonMainColor : .buttonDisabledColor
    }
    
    @objc private func doneButtonPressed() {
        numberTextField.endEditing(true)
    }
    
    @objc func buttonTouchedDown(_ sender: UIButton) {
        sender.animateTouchDown()
    }
    
    @objc func buttonTouchedUpOutside(_ sender: UIButton) {
        sender.animateTouchUp()
    }
    
    @objc private func buttonTouchedUpInside(_ sender: UIButton) {
        sender.animateTouchUp()
        delegate?.guessButtonPressed()
    }
    
    func setWrongAnswerImage() {
        computerImageView.image = wrongAnswerImages.randomElement() as? UIImage
    }
}
