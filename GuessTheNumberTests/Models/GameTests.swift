//
//  GameTests.swift
//  GuessTheNumberTests
//
//  Created by Artem Kvashnin on 13.02.2023.
//

import XCTest
@testable import GuessTheNumber

class GameTests: XCTestCase {
    var sut: Game!
    var firstRoundDelegate: DummyRoundOneGameDelegate!
    var secondRoundDelegate: DummyRoundTwoDelegate!
    
    override func setUp() {
        super.setUp()
        sut = Game(minNumber: 1, maxNumber: 100)
        firstRoundDelegate = DummyRoundOneGameDelegate()
        secondRoundDelegate = DummyRoundTwoDelegate()
        sut.roundOneDelegate = firstRoundDelegate
        sut.roundTwoDelegate = secondRoundDelegate
    }
    
    override func tearDown() {
        sut = nil
        firstRoundDelegate = nil
        secondRoundDelegate = nil
        super.tearDown()
    }
    
    func test_init_setsMinNumber() {
        XCTAssertEqual(sut.initialMinNumber, 1)
    }
    
    func test_init_setsMaxNumber() {
        XCTAssertEqual(sut.initialMaxNumber, 100)
    }
    
    func test_whenSetUserNumber_setsUserNumberProperty() {
        // when
        let userNumber = 50
        try? sut.setUserNumber(userNumber)
        
        // then
        XCTAssertTrue(sut.userNumber == userNumber)
    }
    
    //MARK: -- Round One Tests
    func test_whenComputerGuessingNumber_delegateMethodsCalled() {
        // given
        let exp = expectation(description: "wait 1 second")
        // when
        sut.computerGuessingNumber()
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        
        // then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(firstRoundDelegate.computerThinksCalled)
            XCTAssertTrue(firstRoundDelegate.computerProposeNumberCalled)
        }
    }
    
    func test_whenComputerGuessingNumber_computerTriesCountRaises() {
        // when
        sut.computerGuessingNumber()
        
        // then
        XCTAssertEqual(sut.computerTries, 1)
    }
    
    func test_whenComputerGuessingNumber_computerCurrentGuessSets() {
        // when
        sut.computerGuessingNumber()
        let exp = expectation(description: "wait 1 second")

        // then
        let result = XCTWaiter.wait(for: [exp], timeout: 1)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(firstRoundDelegate.proposedNumber)
        }
    }
    
    func test_whenStartsRoundOne_setsRound() {
        // when
        sut.startRound()
        
        //then
        XCTAssertTrue(sut.round == .roundOne)
    }
    
    func test_whenStartsRoundOne_callsComputerGuessingNumber() {
        // when
        sut.startRound()
        
        //then
        XCTAssertTrue(sut.computerTries == 1)
    }
    
    func test_whenUserAnsweringLess_callsComputerGuessingNumber() {
        // given
        sut.startRound()
        // when
        sut.userAnswering(.less)
        
        // then
        XCTAssertEqual(sut.computerTries, 2)
    }
    
    func test_whenUserAnsweringGreater_callsComputerGuessingNumber() {
        // given
        sut.startRound()
        // when
        sut.userAnswering(.greater)
        
        // then
        XCTAssertEqual(sut.computerTries, 2)
    }
    
    func test_whenUserAnsweringEqual_callsEndRound() {
        // given
        sut.startRound()
        // when
        sut.userAnswering(.equal)
        
        // then
        XCTAssertEqual(sut.round, .roundTwo)
    }
    
    // MARK: -- Round two tests
    
    func whenRoundTwoStarts() {
        sut.startRound()
        sut.endRound()
        sut.startRound()
    }
    
    func whenRoundTwoEnds() {
        sut.startRound()
        sut.endRound()
        sut.startRound()
        sut.endRound()
    }
    
    func test_whenRoundTwoStarts_computerPicksNumberCalledAndSetsNumber() {
        // when
        whenRoundTwoStarts()
        
        //then
        XCTAssertNotNil(sut.computerNumber)
    }
    
    func test_whenRoundTwoStarts_computerPicksNumberCalledAndIncreasesUserTries() {
        //when
        whenRoundTwoStarts()
        
        //then
        XCTAssertEqual(sut.userTries, 1)
    }
    
    func test_whenUserProposeNumber_userTriesIncreases() {
        // given
        whenRoundTwoStarts()
        let number = 50
        
        // when
        try? sut.userProposeNumber(number)
        
        // then
        XCTAssertEqual(sut.userTries, 2)
        
    }
    
    func test_whenUserProposeNumber_callsComputerAnswering() {
        // given
        whenRoundTwoStarts()
        let number = 50
        
        // when
        try? sut.userProposeNumber(number)
        
        // then
        XCTAssertTrue(secondRoundDelegate.computerAnswerCalled)
    }
    
    func test_whenUserProposedLessNumber_computerAnswerIsGreater() {
        // given
        whenRoundTwoStarts()
        let number = sut.computerNumber! - 1
        
        // when
        try? sut.userProposeNumber(number)
        
        // then
        XCTAssertEqual(secondRoundDelegate.computerAnswer, .greater)
    }
    
    func test_whenUserProposedGreaterNumber_computerAnswerIsLess() {
        // given
        whenRoundTwoStarts()
        let number = sut.computerNumber! + 1
        
        // when
        try? sut.userProposeNumber(number)
        
        // then
        XCTAssertEqual(secondRoundDelegate.computerAnswer, .less)
    }
    
    func test_whenUserProposedEqualNumber_computerAnswerIsEqual() {
        // given
        whenRoundTwoStarts()
        let number = sut.computerNumber!
        
        // when
        try? sut.userProposeNumber(number)
        
        // then
        XCTAssertEqual(secondRoundDelegate.computerAnswer, .equal)
    }
    
    func test_whenEndSecondRound_chooseWinnerCalled() {
        // when
        whenRoundTwoEnds()
        
        // then
        XCTAssertTrue(secondRoundDelegate.gameWinnerCalled)
    }
    
    func test_whenEndSecondRound_gameResetsToFirstRound() {
        // when
        whenRoundTwoEnds()
        
        //then
        XCTAssertEqual(sut.round, .roundOne)
    }
    
    func test_whenEndSecondRound_choosesWinner() {
        // given
        whenRoundTwoStarts()
        XCTAssertNil(secondRoundDelegate.winner)
        
        // when
        sut.endRound()
        
        //then
        XCTAssertNotNil(secondRoundDelegate.winner)
    }
    
    
}

extension GameTests {
    class DummyRoundOneGameDelegate: RoundOneGameDelegate {
        var computerProposeNumberCalled = false
        var computerThinksCalled = false
        var proposedNumber: Int?
        
        func computerProposeNumber(_ number: Int) {
            computerProposeNumberCalled = true
            proposedNumber = number
        }
        
        func computerThinks(tryNumber: Int) {
            computerThinksCalled = true
        }
    }
    
    class DummyRoundTwoDelegate: RoundTwoGameDelegate {
        var computerAnswerCalled = false
        var gameWinnerCalled = false
        
        var computerAnswer: Game.Answer?
        var winner: Game.Winner?
        
        
        func computerAnswer(_ answer: GuessTheNumber.Game.Answer, tryNumber: Int) {
            computerAnswerCalled = true
            computerAnswer = answer
        }
        
        func gameWinner(_ winner: GuessTheNumber.Game.Winner, userTries: Int, computerTries: Int) {
            gameWinnerCalled = true
            self.winner = winner
        }
        
        
    }
}
