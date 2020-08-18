//
//  GameTests.swift
//  MotherHelpTests
//
//  Created by Jérôme Guèrin on 18/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import MotherHelp

final class GameTests: XCTestCase {
    
    // MARK: - Initializer
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests all methods
    
    func testBasicInit_WhenEverythingItsOK_ThenShouldHaveANewStudent() {
        let game1 = Game(name: "test1", domain: "test1", typeOfGame: .alpha)
        let game2 = Game(name: "test2", domain: "test2", typeOfGame: .form)
        let game3 = Game(name: "test3", domain: "test3", typeOfGame: .numeric)
        let game4 = Game(name: "test4", domain: "test4", typeOfGame: .sound)
        XCTAssertTrue(game1.name == "test1" && game2.name == "test2" && game3.name == "test3" && game4.name == "test4")
        XCTAssertTrue(game1.effectuate.count == 26 && game2.effectuate.count == 5 && game3.effectuate.count == 24 && game4.effectuate.count == 21)
    }
    
    func testCoreDataInit_WhenEverythingItsOK_ThenShouldHaveANewStudent() {
        let game = Game(name: "test", domain: "test", typeOfGame: .alpha)
        coreDataManager.create(game: game)
        let testGame = Game(withCoreData: coreDataManager.games[0])
        XCTAssertTrue(testGame.name == "test")
        XCTAssertTrue(testGame.domain == "test")
        XCTAssertTrue(testGame.effectuate.count == 26)
    }
}
