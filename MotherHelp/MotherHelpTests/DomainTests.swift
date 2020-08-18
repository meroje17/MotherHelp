//
//  DomainTests.swift
//  MotherHelpTests
//
//  Created by Jérôme Guèrin on 18/08/2020.
//  Copyright © 2020 Jérôme Guèrin. All rights reserved.
//

import XCTest
@testable import MotherHelp

final class DomainTests: XCTestCase {
    
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
        let domain = Domain(name: "test")
        XCTAssertTrue(domain.name == "test")
    }
    
    func testCoreDataInit_WhenEverythingItsOK_ThenShouldHaveANewStudent() {
        let domain = Domain(name: "test")
        coreDataManager.create(domain: domain)
        let testDomain = Domain(withCoreData: coreDataManager.domains[0])
        XCTAssertTrue(testDomain.name == "test")
    }
}
