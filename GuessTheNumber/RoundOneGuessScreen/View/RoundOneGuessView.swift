//
//  RoundOneGuessView.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 17.01.2023.
//

import UIKit
import SnapKit

protocol RoundOneGuessViewDelegate: AnyObject {
    func lessButtonTapped()
    func equalButtonTapped()
    func greaterButtonTapped()
}

class RoundOneGuessView: UIView {
    
    weak var delegate: RoundOneGuessViewDelegate?
    
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
    
    let buttonsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let lessButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xF18787)
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let equalButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0xACE399)
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let greaterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x83F2D8)
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    let reminderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let backgroundView = BackgroundView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(rgb: 0xF6F1D3)
        
        buttonsStackView.addArrangedSubview(lessButton)
        buttonsStackView.addArrangedSubview(equalButton)
        buttonsStackView.addArrangedSubview(greaterButton)
        
        addSubview(backgroundView)
        addSubview(roundTitleLabel)
        addSubview(triesLabel)
        addSubview(guessLabel)
        addSubview(computerImageView)
        addSubview(buttonsTitleLabel)
        addSubview(buttonsStackView)
        addSubview(reminderLabel)
        
        lessButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        greaterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setupTitles()
        setupConstraints()
    }
    
    private func setupTitles() {
        roundTitleLabel.text = "Round One"
        buttonsTitleLabel.text = "Your Number is:"
        lessButton.setTitle("Less", for: .normal)
        equalButton.setTitle("That's it", for: .normal)
        greaterButton.setTitle("Greater", for: .normal)
        
        //Mock titles
        triesLabel.text = "Try #1"
        guessLabel.text = "Your number is 44 ?"
        reminderLabel.text = "Reminder: you number is 100"
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
        guessLabel.snp.makeConstraints { make in
            make.top.equalTo(triesLabel.snp.bottom).offset(50)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        computerImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.33)
            make.height.equalTo(computerImageView.snp.width)
            make.center.equalToSuperview()
        }
        buttonsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(computerImageView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
        }
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(buttonsTitleLabel.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        reminderLabel.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == lessButton {
            delegate?.lessButtonTapped()
        } else if sender == equalButton {
            delegate?.equalButtonTapped()
        } else if sender == greaterButton {
            delegate?.greaterButtonTapped()
        }
    }
}
