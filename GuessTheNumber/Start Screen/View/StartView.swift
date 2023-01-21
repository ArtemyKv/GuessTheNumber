//
//  StartView.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 12.01.2023.
//

import UIKit
import SnapKit

protocol StartViewDelegate: AnyObject {
    func startButtonPressed()
    func rulesButtonPressed()
}

class StartView: UIView {
    
    weak var delegate: StartViewDelegate?

    let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Guess The Number"
        return label
    }()
    
    let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Welcome!\nIn this game you will challenge the computer \nin guessing numbers"
        return label
    }()
    
    let startTipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Press button to start new game"
        return label
    }()
    
    let startButton: RoundButton = {
        let button = RoundButton()
        button.backgroundColor = UIColor(rgb: 0xACE399)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    let rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Game rules", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let backgroundView = BackgroundView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraint references
    var gameTitleLabelCenterXConstraint: Constraint?
    var gameDescriptionLabelCenterXConstraint: Constraint?
    var tipLabelTopConstraint: Constraint?
    
    func setupView() {
        backgroundColor = UIColor(rgb: 0xF6F1D3)
        
        startButton.addTarget(self, action: #selector(buttonTouchedUpInside), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        startButton.addTarget(self, action: #selector(buttonTouchedUpOutside), for: .touchUpOutside)
        rulesButton.addTarget(self, action: #selector(buttonTouchedUpInside), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        rulesButton.addTarget(self, action: #selector(buttonTouchedUpOutside), for: .touchUpOutside)
        
        addSubview(backgroundView)
        addSubview(gameTitleLabel)
        addSubview(gameDescriptionLabel)
        addSubview(startButton)
        addSubview(startTipLabel)
        addSubview(rulesButton)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            self.gameTitleLabelCenterXConstraint = make.centerX.equalToSuperview().constraint
        }
        
        gameDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(65)
            self.gameDescriptionLabelCenterXConstraint = make.centerX.equalToSuperview().constraint
        }
        
        startButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 125, height: 125))
            make.top.equalTo(gameDescriptionLabel.snp.bottom).offset(150)
            make.centerX.equalToSuperview()
        }
        
        startTipLabel.snp.makeConstraints { make in
            self.tipLabelTopConstraint = make.top.equalTo(startButton.snp.bottom).offset(25).constraint
            make.horizontalEdges.equalToSuperview()
        }
        
        rulesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc private func buttonTouchedUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = .identity
            sender.alpha = 1.0
        }
        if sender == startButton {
            delegate?.startButtonPressed()
        } else if sender == rulesButton {
            delegate?.rulesButtonPressed()
        }
    }
    
    @objc private func buttonTouchedUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = .identity
            sender.alpha = 1.0
        }
    }
    
    @objc private func buttonTouchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.alpha = 0.6
        }
    }
    
    func prepareForAppearance() {
        gameTitleLabelCenterXConstraint?.update(offset: -self.frame.width)
        gameDescriptionLabelCenterXConstraint?.update(offset: -self.frame.width)
        tipLabelTopConstraint?.update(offset: 50)
        layoutIfNeeded()
        startButton.alpha = 0.0
        startTipLabel.alpha = 0.0
    }

    func animateAppearance() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1) {
            self.gameTitleLabelCenterXConstraint?.update(offset: 0)
            self.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1) {
            self.gameDescriptionLabelCenterXConstraint?.update(offset: 0)
            self.layoutIfNeeded()
        }
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            animations: {
                self.startButton.alpha = 1.0
            },
            completion: { _ in
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.2) {
                    self.startTipLabel.alpha = 1.0
                    
                    self.tipLabelTopConstraint?.update(offset: 25)
                    self.layoutIfNeeded()
                }
            })
    }
}
