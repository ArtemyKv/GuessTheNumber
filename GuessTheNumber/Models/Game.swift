//
//  Game.swift
//  GuessTheNumber
//
//  Created by Artem Kvashnin on 17.01.2023.
//

import Foundation

protocol RoundOneGameDelegate: AnyObject {
    func computerProposeNumber(_ number: Int)
    func computerThinks(tryNumber: Int)
}

protocol RoundTwoGameDelegate: AnyObject {
    func computerAnswer(_ answer: Game.Answer, tryNumber: Int)
    func gameWinner(_ winner: Game.Winner, userTries: Int, computerTries: Int)
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
    
    enum Winner {
        case user
        case computer
        case draw
    }
    
    enum GameError: Error {
        case numberOutOfBounds
    }
    
    init(minNumber: Int, maxNumber: Int) {
        self.initialMinNumber = minNumber
        self.initialMaxNumber = maxNumber
    }
    
    weak var roundOneDelegate: RoundOneGameDelegate?
    weak var roundTwoDelegate: RoundTwoGameDelegate?
    
    private (set) var round: GameRound = .roundOne
    
    private (set) var initialMinNumber: Int
    private (set) var initialMaxNumber: Int
    
    private lazy var minNumber: Int = initialMinNumber
    private lazy var maxNumber: Int = initialMaxNumber
    
    private (set) var computerNumber: Int?
    private (set) var userNumber: Int?
    
    var userTries = 0
    var computerTries = 0
    
    private var userCurrentGuess: Int?
    private var computerCurrentGuess: Int?
    
    //MARK: - Round One methods
    func setUserNumber(_ number: Int) throws {
        guard number >= initialMinNumber,
              number <= initialMaxNumber
        else { throw GameError.numberOutOfBounds }
        userNumber = number
    }
    
    func computerGuessingNumber() {
        switch computerTries {
            case 0:
                computerCurrentGuess = minNumber
            case 1:
                computerCurrentGuess = maxNumber
            case 2:
                computerCurrentGuess = Int.random(in: (minNumber + 1)...(maxNumber - 1))
            default:
                computerCurrentGuess = (minNumber + maxNumber) / 2
        }
        computerTries += 1
        roundOneDelegate?.computerThinks(tryNumber: computerTries)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.roundOneDelegate?.computerProposeNumber(self.computerCurrentGuess!)
        }
    }
    
    func userAnswering(_ answer: Answer) {
        guard let computerCurrentGuess else { return }
        switch answer {
            case .less:
                maxNumber = computerCurrentGuess
                computerGuessingNumber()
            case .greater:
                minNumber = computerCurrentGuess
                computerGuessingNumber()
            case .equal:
                endRound()
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
        roundTwoDelegate?.computerAnswer(answer, tryNumber: userTries)
    }
    
    func userProposeNumber(_ number: Int) throws {
        guard number >= initialMinNumber,
              number <= initialMaxNumber
        else { throw GameError.numberOutOfBounds }
        
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
    
    private func endGame() {
        chooseWinner()
        resetGame()
    }
    
    private func chooseWinner() {
        var winner: Winner
        if computerTries > userTries {
            winner = .user
        } else if userTries > computerTries {
            winner = .computer
        } else {
            winner = .draw
        }
        roundTwoDelegate?.gameWinner(winner, userTries: userTries, computerTries: computerTries)
    }
    
    func resetGame() {
        computerNumber = nil
        userNumber = nil
        computerTries = 0
        userTries = 0
        userCurrentGuess = nil
        computerCurrentGuess = nil
        round = .roundOne
    }
}


