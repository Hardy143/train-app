//
//  StationListViewModelTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 06/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
import CoreData
@testable import Train_App

class StationListViewModelTests: XCTestCase {
    
    var sut: StationListViewModel!
    var mockStationDataManager: MockStationDataManager!
    var mockJsonParser: MockJsonParser!
    
    class MockStationDataManager: StationDataManagerProtocol {
        
        var isStationPresent: Bool
        
        init(isStationPresent: Bool) {
            self.isStationPresent = isStationPresent
        }
        
        var isFetchAllStationsCalled = false
        
        func fetchStationByName(name: String) -> Station? { return nil }
        func createStation(name: String) {}
        func deleteStation(name: String) {}
        
        func fetchAllStations() -> [Station] {
            isFetchAllStationsCalled = true
            
            if isStationPresent {
                let mockDatabaseManager = MockDatabaseManager()
                let station = Station(context: mockDatabaseManager.mainContext)
                station.name = "testStation"
                    
                try? mockDatabaseManager.mainContext.save()
                
                return [station]
            }
            return []
        }
        
    }
    
    class MockJsonParser: Parser {
        
        var isParseCalled = false
        
        func parse(url: String, completion: @escaping ([Any]) -> Void) {
            isParseCalled = true
            let station1 = "test1"
            let station2 = "test2"
            completion([station1, station2])
        }
        
    }
    
    override func setUpWithError() throws {
        mockStationDataManager = MockStationDataManager(isStationPresent: true)
        mockJsonParser = MockJsonParser()
        sut = StationListViewModel(stationDataManager: mockStationDataManager, jsonParser: mockJsonParser)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockStationDataManager = nil
        mockJsonParser = nil
    }

    func test_savedStations_fetchAllStationsIsCalled() {
        // Given
        let expected = true
        
        // When
        let _ = sut.savedStations
        let actual = mockStationDataManager.isFetchAllStationsCalled
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_savedStations_countIs0() {
        // Given
        let testStationDataManager = MockStationDataManager(isStationPresent: false)
        sut = StationListViewModel(stationDataManager: testStationDataManager, jsonParser: mockJsonParser)
        let expected = 0
        
        // When
        let savedStations = sut.savedStations
        let actual = savedStations.count
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_savedStations_countIs1() {
        // Given
        let expected = 1
        
        // When
        let savedStations = sut.savedStations
        let actual = savedStations.count
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_savedStations_stationViewModelNameIsTestStation() {
        // Given
        let expected = "testStation"
        
        // When
        let savedStations = sut.savedStations
        
        guard let station = savedStations.first else {
            XCTFail("no stations returned")
            return
        }
        
        let actual = station.name
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_getStations_parseIsCalled() {
        // Given
        let expected = true
        let parseExpectation = expectation(description: "parser is called")
        
        // When
        sut.getStations { _ in
            parseExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("test failed due to error: \(error)")
            }
            
            let actual = self.mockJsonParser.isParseCalled
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func test_getStations_stationViewModelCountIs2() {
        // Given
        let expected = 2
        var actual = 0
        let stationViewModelExpectation = expectation(description: "station view model")
    
        // When
        sut.getStations { stationViewModels in
            actual = stationViewModels.count
            stationViewModelExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("test failed due to error: \(error)")
            }
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func test_getStations_firstStationViewModelNameIsTest1() {
        // Given
        let expected = "test1"
        var actual = ""
        let stationViewModelExpectation = expectation(description: "station view model is returned")
    
        // When
        sut.getStations { stationViewModels in
            if let viewModel = stationViewModels.first {
                actual = viewModel.name
            }
            stationViewModelExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("test failed due to error: \(error)")
            }
            
            XCTAssertEqual(expected, actual)
        }
    }

}
