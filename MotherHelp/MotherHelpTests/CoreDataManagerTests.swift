//
//  CoreDataManagerTests.swift
//  MotherHelpTests
//
//  Created by Jérôme Guèrin on 18/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import MotherHelp

final class CoreDataManagerTests: XCTestCase {
    
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
    
    // MARK: - Tests CREATE methods
    
    func testCreateDomainMethod_WhenEverythingItsOk_ThenShouldHaveADomainSaved() {
        coreDataManager.create(domain: Domain(name: "Mathématique"))
        XCTAssertTrue(coreDataManager.domains.count == 1)
        XCTAssertTrue(coreDataManager.domains[0].name == "Mathématique")
    }
    
    func testCreateGameMethod_WhenEverythingItsOk_ThenShouldHaveAGameSaved() {
        coreDataManager.create(game: Game(name: "Addition", domain: "Math", typeOfGame: .numeric))
        XCTAssertTrue(coreDataManager.games.count == 1)
        XCTAssertTrue(coreDataManager.games[0].name == "Addition")
        XCTAssertTrue(coreDataManager.games[0].domain == "Math")
        for number in 1...24 {
            XCTAssertTrue(coreDataManager.games[0].type!.contains("\(number)"))
        }
    }
    
    func testCreateStudentMethod_WhenEverythingItsOk_ThenShouldHaveAStudentSaved() {
        coreDataManager.create(student: Student(name: "Eleve", games: ["Addition": ["1": false, "2": true]]))
        XCTAssertTrue(coreDataManager.students.count == 1)
        XCTAssertTrue(coreDataManager.students[0].name == "Eleve")
        XCTAssertTrue(coreDataManager.students[0].games!.count == 1)
        XCTAssertTrue(coreDataManager.students[0].games!["Addition"]!["1"] == false)
        XCTAssertTrue(coreDataManager.students[0].games!["Addition"]!["2"] == true)
    }
    
    // MARK: - Tests UPDATE method
    
    func testUpdateStudentMethod_WhenEverythingItsOk_ThenShouldHaveNewValueInStudentSaved() {
        let student = Student(name: "Eleve", games: ["Addition": ["1": false, "2": true]])
        coreDataManager.create(student: student)
        student.games = ["Addition": ["1": false, "2": false]]
        coreDataManager.update(student: student)
        XCTAssertTrue(coreDataManager.students.count == 1)
        XCTAssertTrue(coreDataManager.students[0].name == "Eleve")
        XCTAssertTrue(coreDataManager.students[0].games!.count == 1)
        XCTAssertTrue(coreDataManager.students[0].games!["Addition"]!["1"] == false)
        XCTAssertTrue(coreDataManager.students[0].games!["Addition"]!["2"] == false)
    }
    
    // MARK: - Tests DELETE methods
    
    func testDeleteDomainMethod_WhenEverythingItsOk_ThenShouldHaveEmptyCoreDataDomainList() {
        let domain = Domain(name: "test")
        coreDataManager.create(domain: domain)
        XCTAssertTrue(coreDataManager.domains.count == 1)
        coreDataManager.deleteDomain(named: "test")
        XCTAssertTrue(coreDataManager.domains.count == 0)
    }
    
    func testDeleteGameMethod_WhenEverythingItsOk_ThenShouldHaveEmptyCoreDataGameList() {
        let game = Game(name: "test", domain: "test", typeOfGame: .alpha)
        coreDataManager.create(game: game)
        XCTAssertTrue(coreDataManager.games.count == 1)
        coreDataManager.deleteGame(named: "test")
        XCTAssertTrue(coreDataManager.games.count == 0)
    }
    
    func testDeleteStudentMethod_WhenEverythingItsOk_ThenShouldHaveEmptyCoreDataStudentList() {
        let student = Student(name: "test", games: ["test": ["test": true]])
        coreDataManager.create(student: student)
        XCTAssertTrue(coreDataManager.students.count == 1)
        coreDataManager.deleteStudent(named: "test")
        XCTAssertTrue(coreDataManager.students.count == 0)
    }
}
