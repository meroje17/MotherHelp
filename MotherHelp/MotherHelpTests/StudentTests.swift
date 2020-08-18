//
//  StudentTests.swift
//  MotherHelpTests
//
//  Created by Jérôme Guèrin on 18/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import MotherHelp

final class StudentTests: XCTestCase {
    
    // MARK: - Initializer
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        Student.list = [Student]()
    }

    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
        Student.list = [Student]()
    }
    
    // MARK: - Tests all methods
    
    func testBasicInit_WhenEverythingItsOK_ThenShouldHaveANewStudent() {
        let student = Student(name: "test", games: ["test": ["test": false]])
        XCTAssertTrue(student.name == "test")
        XCTAssertTrue(student.games.count == 1)
        XCTAssertTrue(student.games["test"]!.count == 1)
        XCTAssertTrue(student.games["test"]!["test"]! == false)
    }
    
    func testCoreDataInit_WhenEverythingItsOK_ThenShouldHaveANewStudent() {
        let student = Student(name: "test", games: ["test": ["test": false]])
        coreDataManager.create(student: student)
        let testStudent = Student(withCoreData: coreDataManager.students[0])
        XCTAssertTrue(testStudent.name == "test")
        XCTAssertTrue(testStudent.games.count == 1)
        XCTAssertTrue(testStudent.games["test"]!.count == 1)
        XCTAssertTrue(testStudent.games["test"]!["test"]! == false)
    }
    
    func testIsTheGameDoneMethod_WhenEverythingItsOK_ThenShouldChangeBooleanValueInStudentGame() {
        let student = Student(name: "test", games: ["test": ["test": false]])
        student.isTheGameDone(named: "test", atIndex: "test", true)
        XCTAssertTrue(student.games["test"]!["test"]! == true)
    }
    
    func testAddingGameMethod_WhenEverythingItsOK_ThenShouldHaveANewGameInStudentGames() {
        let student = Student(name: "test", games: ["test": ["test": false]])
        let game = Game(name: "GameTest", domain: "DomainTest", typeOfGame: .numeric)
        student.addingGame(named: game)
        XCTAssertTrue(student.games.count == 2)
        XCTAssertTrue(student.games["test"] != nil)
        XCTAssertTrue(student.games["GameTest"] != nil)
    }
}
