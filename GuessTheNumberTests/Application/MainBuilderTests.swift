//
//  MainBuilderTests.swift
//  GuessTheNumberTests
//
//  Created by Artem Kvashnin on 14.02.2023.
//

import XCTest
@testable import GuessTheNumber

class MainBuilderTests: XCTestCase {
    var sut: MainBuilder!
    var mockCoordinator = MockCoordinator()
    
    override func setUp() {
        super.setUp()
        sut = MainBuilder()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenInit_setsGame() {
        XCTAssertNotNil(sut.game)
    }
    
    func test_whenStartScreen_setsPresenter() {
        // when
        let vc = sut.startScreen(coordinator: mockCoordinator)
        
        // then
        XCTAssertNotNil((vc as? StartViewController)?.presenter)
    }
    
    func test_whenRoundOneNumberSelectScreen_setsPresenter() {
        // when
        let vc = sut.roundOneNumberSelectScreen(coordinator: mockCoordinator)
        
        // then
        XCTAssertNotNil((vc as? RoundOneNumberSelectViewController)?.presenter)
    }
    
    func test_whenRoundOneGuessScreen_setsPresenter() {
        // when
        let vc = sut.roundOneGuessScreen(coordinator: mockCoordinator)
        
        // then
        XCTAssertNotNil((vc as? RoundOneGuessViewController)?.presenter)
    }
    
    func test_whenRoundTwoScreen_setsPresenter() {
        // when
        let vc = sut.roundTwoScreen(coordinator: mockCoordinator)
        
        // then
        XCTAssertNotNil((vc as? RoundTwoViewController)?.presenter)
    }
}

extension MainBuilderTests {
    class MockCoordinator: MainCoordinatorProtocol {
        var navigationController = UINavigationController()
        
        func showRoundOneFirstScreen() { }
        
        func showRoundOneGuessScreen() { }
        
        func showRoundTwoScreen() { }
        
        func popToStartScreen() { }
        
        func start() { }
        
    }
}
