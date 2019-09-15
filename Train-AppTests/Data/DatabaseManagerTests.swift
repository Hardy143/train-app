//
//  DatabaseManagerTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 15/09/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData
import XCTest
@testable import Train_App

class DatabaseManagerTests: XCTestCase {
    
    var sut: DatabaseManager!

    override func setUp() {
        super.setUp()
        sut = DatabaseManager()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

// MARK: - Set up tests
extension DatabaseManagerTests {
    
    func testSetup_completionCalled() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSInMemoryStoreType) {
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testSetup_persistentStoreCreated() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup(storeType: NSInMemoryStoreType) {
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertTrue(self.sut.persistentContainer.persistentStoreCoordinator.persistentStores.count > 0)
        }
    }
    
    func testSetup_persistentContainerLoadedOnDisk() {
        let setupExpectation = expectation(description: "set up completion called")
        
        sut.setup {
            XCTAssertEqual(self.sut.persistentContainer.persistentStoreDescriptions.first?.type, NSSQLiteStoreType)
            setupExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            self.sut.persistentContainer.persistentStoreCoordinator.destroyPersistentStore(type: NSSQLiteStoreType)
            
        }
    }
}
