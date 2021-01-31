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
        expectation(forNotification: .NSManagedObjectContextDidSave, object: mockDatabaseManager.backgroundContext) { _ in
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

// MARK: - Delete Tests

extension StationDataManagerTests {
    
    func test_deleteStation_CountIs0() {
        // Given
        createMockData(with: 1)
        let testStation = fetchAllStations().first
        let expectedCount = 0
        
        guard let station = testStation else {
            XCTFail("No stations fetched")
            return
        }
        
        // When
        sut.deleteStation(station: station)
        
        // Then
        let actualCount = fetchAllStations().count
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func test_deleteStation_test1IsDeleted() {
        // Given
        createMockData(with: 4)
        let stationToDelete = fetchAllStations()[1]
        let stationId = stationToDelete.objectID
        
        // When
        sut.deleteStation(station: stationToDelete)
        
        // Then
        let result = sut.fetchAllStations()
        let exists = result.contains(where: { $0.objectID == stationId })
        
        XCTAssertFalse(exists)
    }
    
}

// MARK: - Fetch Tests
extension StationDataManagerTests {
    
    func test_fetchAllStations_countIs10() {
        // Given
        createMockData(with: 10)
        let expectedCount = 10
        
        // When
        let actualCount = sut.fetchAllStations().count
        
        // Then
        XCTAssertEqual(expectedCount, actualCount)
    }
    
    func test_fetchStationByName() {
        // Given
        createMockData(with: 6)
        let expectedStationName = "test3"
        
        // When
        guard let actualStationName = sut.fetchStationByName(name: expectedStationName)?.name else {
            XCTFail("No station found")
            return
        }
        
        // Then
        XCTAssertEqual(expectedStationName, actualStationName)
    }
}

// MARK: - Helper methods
extension StationDataManagerTests {
    
    private func createMockData(with count: Int) {
        let backgroundContext = mockDatabaseManager.backgroundContext
        
        backgroundContext.performAndWait {
            
            for index in 1...count {
                let station = NSEntityDescription.insertNewObject(forEntityName: Station.description(), into: backgroundContext) as! Station
                station.name = "test\(index)"
            }
            
            backgroundContext.performAndWait {
                try? backgroundContext.save()                
            }
            
        }
        
    }
    
    private func fetchAllStations() -> [Station] {
        let request: NSFetchRequest<Station> = Station.fetchRequest()
        let stations = try? self.mockDatabaseManager.mainContext.fetch(request)
        
        return stations ?? []
    }
    
}
