//
//  StationDataManagerTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 24/01/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import CoreData
import XCTest
@testable import Train_App

class StationDataManagerTests: XCTestCase {
    
    var sut: StationDataManager!
    var mockDatabaseManager: MockDatabaseManager!

    override func setUp() {
        super.setUp()
        mockDatabaseManager = MockDatabaseManager()
        sut = StationDataManager(mainContext: mockDatabaseManager.mainContext, backgroundContext: mockDatabaseManager.backgroundContext)
        
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockDatabaseManager = nil
    }
    
}

// MARK: - Create Tests

extension StationDataManagerTests {
    
    func test_createStation_stationNameIsTestStation() {
        // Given
        let expected = "TestStation"
        
        // When
        sut.createStation(name: "TestStation")

        // Then
        let request: NSFetchRequest<Station> = Station.fetchRequest()
        let stations = try? self.mockDatabaseManager.mainContext.fetch(request)

        guard let station = stations?.first else {
            XCTFail("station missing")
            return
        }

        let actual = station.name

        XCTAssertEqual(expected, actual)

    }
    
    func test_createStation_SaveIsCalled() {
        // Given
        expectation(
            forNotification: .NSManagedObjectContextDidSave,
            object: mockDatabaseManager.backgroundContext) { _ in
              return true
          }
        
        // When
        sut.createStation(name: "TestStation")
        
        // Then
        waitForExpectations(timeout: 2.0) { error in
        XCTAssertNil(error, "Save did not occur")
      }
    }
    
    func test_createStation_CountIs1() {
        // Given
        let expected = 1
        
        // When
        sut.createStation(name: "TestStation")
        
        let request: NSFetchRequest<Station> = Station.fetchRequest()
        let stations = try? self.mockDatabaseManager.mainContext.fetch(request)

        let actual = stations?.count
        
        // Then
        XCTAssertEqual(expected, actual)
    }


}

// MARK: - Helper methods
extension StationDataManagerTests {
    
    func createMockData() {
        
    }
    
}
