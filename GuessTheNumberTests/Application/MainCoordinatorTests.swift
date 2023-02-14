//
//  MainCoordinatorTests.swift
//  GuessTheNumberTests
//
//  Created by Artem Kvashnin on 14.02.2023.
//

import XCTest
@testable import GuessTheNumber

class MainCoordinatorTests: XCTestCase {
    var sut: MainCoordinator!
    var mockNavigationVC: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        let builder = MainBuilder()
        mockNavigationVC = MockNavigationController()
        sut = MainCoordinator(navigationController: mockNavigationVC, builder: builder)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_whenStart_StartVCPushed() {
        // when
        sut.start()
        
        // then
        XCTAssertTrue(mockNavigationVC.presentedVC is StartViewController)
    }
    
    func test_whenShowRoundOneFirstScreen_roundOneNumberSelectVCPushed() {
        // when
        sut.showRoundOneFirstScreen()
        
        // then
        XCTAssertTrue(mockNavigationVC.presentedVC is RoundOneNumberSelectViewController)
    }
    
    func test_whenShowRoundOneGuessScreen_roundOneGuessVCPushed() {
        // when
        sut.showRoundOneGuessScreen()
        
        // then
        XCTAssertTrue(mockNavigationVC.presentedVC is RoundOneGuessViewController)
    }
    
    func test_whenShowRoundTwoScreen_RoundTwoVCPushed() {
        // when
        sut.showRoundTwoScreen()
        
        // then
        XCTAssertTrue(mockNavigationVC.presentedVC is RoundTwoViewController)
    }
    
    func test_whenPopToStartScreen_topVCIsStartScreen() {
        // given
        sut.start()
        sut.showRoundOneFirstScreen()
        
        // when
        sut.popToStartScreen()
        
        // then
        XCTAssertTrue(mockNavigationVC.topViewController is StartViewController)
    }
    
    
}

extension MainCoordinatorTests {
    class MockNavigationController: UINavigationController {
        var presentedVC: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            presentedVC = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
