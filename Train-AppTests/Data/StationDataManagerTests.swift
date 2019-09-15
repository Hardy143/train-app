//
//  StationDataManagerTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 15/09/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import CoreData
import XCTest
@testable import Train_App

class StationDataManagerTests: XCTestCase {
    
    var sut: StationDataManager!
    var coreDataStack: CoreDataTestStack!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        sut = StationDataManager(backgroundContext: coreDataStack.backgroundContext)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

// MARK: - Init tests
extension StationDataManagerTests {
    
    func testInit_contexts() {
        XCTAssertEqual(sut.backgroundContext, coreDataStack.backgroundContext)
    }
}

// MARK: - CRUD tests
extension StationDataManagerTests {
    
    func testCreateStation_stationCreated() {
        // Given
        let performAndWaitExpectation = expectation(description: "background perform and wait")
        coreDataStack.backgroundContext.expectation = performAndWaitExpectation
        
        // When
        sut.createStation(name: "Bangor")
        
        waitForExpectations(timeout: 1.0) { _ in
            let request = NSFetchRequest<StationDB>.init(entityName: StationDB.description())
            let stations = try! self.coreDataStack.backgroundContext.fetch(request)
            
            guard let station = stations.first else {
                XCTFail("station missing")
                return
            }
            
            XCTAssertEqual(stations.count, 1)
            XCTAssertNotNil(station.name)
            XCTAssertEqual(station.name, "Bangor")
            XCTAssertTrue(self.coreDataStack.backgroundContext.saveWasCalled)
        }
    }
    
    func testFetchAllStations_stationsReturned() {
        // Given
        let _ = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        let _ = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        let _ = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        
        // When
        let stations = sut.fetchAllStations()
        
        // Then
        XCTAssertEqual(stations.count, 3)
    }
    
    func testDeleteStation_stationDeleted() {
        // Given
        let performAndWaitExpectation = expectation(description: "background perform and wait")
        coreDataStack.backgroundContext.expectation = performAndWaitExpectation
        
        let stationA = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        let stationB = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        let stationC = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
        
        // When
        sut.deleteStation(station: stationB)
        
        // Then
        waitForExpectations(timeout: 1.0) { _ in
            let request = NSFetchRequest<StationDB>.init(entityName: StationDB.description())
            let backgroundContextStations = try! self.coreDataStack.backgroundContext.fetch(request)
            
            XCTAssertEqual(backgroundContextStations.count, 2)
            XCTAssertTrue(backgroundContextStations.contains(stationA))
            XCTAssertTrue(backgroundContextStations.contains(stationC))
            XCTAssertTrue(self.coreDataStack.backgroundContext.saveWasCalled)
        }
        
        func testDeleteStation_switchingContexts_stationDeleted() {
            // Given
            let performAndWaitExpectation = expectation(description: "background perform and wait")
            coreDataStack.backgroundContext.expectation = performAndWaitExpectation
            
            let stationA = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
            let stationB = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
            let stationC = NSEntityDescription.insertNewObject(forEntityName: StationDB.description(), into: self.coreDataStack.backgroundContext) as! StationDB
            
            let mainContextStation = coreDataStack.mainContext.object(with: stationB.objectID) as! StationDB
            
            // When
            sut.deleteStation(station: mainContextStation)
            
            // Then
            waitForExpectations(timeout: 1.0) { _ in
                let request = NSFetchRequest<StationDB>.init(entityName: StationDB.description())
                let backgroundContextStations = try! self.coreDataStack.backgroundContext.fetch(request)
                
                XCTAssertEqual(backgroundContextStations.count, 2)
                XCTAssertTrue(backgroundContextStations.contains(stationA))
                XCTAssertTrue(backgroundContextStations.contains(stationC))
                XCTAssertTrue(self.coreDataStack.backgroundContext.saveWasCalled)
            }
        }
        
    }
}
