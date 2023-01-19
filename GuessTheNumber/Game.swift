//
//  Game.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 17.01.2023.
//

import Foundation

protocol RoundOneGameDelegate: AnyObject {
    func computerProposeNumber(_ number: Int, tryNumber: Int)
}

protocol RoundTwoGameDelegate: AnyObject {
    func computerAnswer(_ answer: Game.Answer, tryNumber: Int)
}

class Game {
    
    enum GameRound {
        case roundOne
        case roundTwo
    }
    
    enum Answer {
        case less
        case equal
        case greater
    }
    
    init(minNumber: Int, maxNumber: Int) {
        self.initialMinNumber = minNumber
        self.initialMaxNumber = maxNumber
    }
    
    weak var roundOneDelegate: RoundOneGameDelegate?
    weak var roundTwoDelegate: RoundTwoGameDelegate?
    
    var round: GameRound = .roundOne
    
    private var initialMinNumber: Int
    private var initialMaxNumber: Int
    
    private lazy var minNumber: Int = initialMinNumber
    private lazy var maxNumber: Int = initialMaxNumber
    
    var computerNumber: Int?
    var userNumber: Int?
    
    var userTries = 0
    var computerTries = 0
    
    private var userCurrentGuess: Int?
    private var computerCurrentGuess: Int?
    
    private var userAnswer: Answer?
    private var computerAnswer: Answer?
    
    //MARK: - Round One methods
    func setUserNumber(_ number: Int) {
        userNumber = number
    }
    
    private func computerGuessingNumber() {
        var proposedNumber: Int
        switch computerTries {
            case 0:
                proposedNumber = minNumber
            case 1:
                proposedNumber = maxNumber
            case 2:
                proposedNumber = Int.random(in: (minNumber + 1)...(maxNumber - 1))
            default:
                proposedNumber = (minNumber + maxNumber) / 2
        }
        computerCurrentGuess = proposedNumber
        computerTries += 1
        roundOneDelegate?.computerProposeNumber(proposedNumber, tryNumber: computerTries)
    }
    
    func userAnswering(_ answer: Answer) {
        guard let computerCurrentGuess = computerCurrentGuess else { return }
        self.userAnswer = answer
        
        switch userAnswer {
            case .less:
                maxNumber = computerCurrentGuess
                computerGuessingNumber()
            case .greater:
                minNumber = computerCurrentGuess
                computerGuessingNumber()
            case .equal:
                endRound()
            case nil:
                return
        }
    }
    
    //MARK: - RoundTwo Methods
    
    private func computerPicksNumber() {
        computerNumber = Int.random(in: minNumber...maxNumber)
        userTries += 1
    }
    
    private func computerAnswering() {
        guard let computerNumber, let userCurrentGuess else { return }
        let answer: Answer
        
        if userCurrentGuess == computerNumber {
            answer = .equal
        }
        else if userCurrentGuess < computerNumber {
            answer = .greater
        }
        else {
            answer = .less
        }
        computerAnswer = answer
        roundTwoDelegate?.computerAnswer(answer, tryNumber: userTries)
    }
    
    func userProposeNumber(_ number: Int) {
        userCurrentGuess = number
        userTries += 1
        computerAnswering()
    }
    
    //MARK: - Game flow Methods
    func startRound() {
        switch round {
            case .roundOne:
                computerGuessingNumber()
            case .roundTwo:
                computerPicksNumber()
                
        }
    }
    
    func endRound() {
        switch round {
            case .roundOne:
                minNumber = initialMinNumber
                maxNumber = initialMaxNumber
                round = .roundTwo
            case .roundTwo:
                endGame()
        }
    }
    
    func endGame() {
        
    }
}


