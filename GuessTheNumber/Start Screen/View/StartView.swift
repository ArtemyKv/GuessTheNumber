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
        label.text = "Welcome!\nIn this game you will challenge the computer in guessing numbers"
        return label
    }()
    
    let startTipLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Press buton to start new game"
        return label
    }()
    
    let startButton: RoundButton = {
        let button = RoundButton()
        button.backgroundColor = UIColor(rgb: 0xACE399)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .regular)
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Game rules", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor(rgb: 0xF6F1D3)
        
        startButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        addSubview(gameTitleLabel)
        addSubview(gameDescriptionLabel)
        addSubview(startButton)
        addSubview(startTipLabel)
        addSubview(rulesButton)
        
        gameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        gameDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(gameTitleLabel.snp.bottom).offset(65)
            make.horizontalEdges.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 125, height: 125))
            make.top.equalTo(gameDescriptionLabel.snp.bottom).offset(150)
            make.centerX.equalToSuperview()
        }
        
        startTipLabel.snp.makeConstraints { make in
            make.top.equalTo(startButton.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview()
        }
        
        rulesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if sender == startButton {
            delegate?.startButtonPressed()
        } else if sender == rulesButton {
            delegate?.rulesButtonPressed()
        }
    }

}
