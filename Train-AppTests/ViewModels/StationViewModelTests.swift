//
//  StationViewModelTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 06/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class StationViewModelTests: XCTestCase {
    
    var sut: StationViewModel!
    var mockStationDataManager: MockStationDataManager!
    
    class MockStationDataManager: StationDataManagerProtocol {
        
        var isStationFetched: Bool
        var isCreateStationCalled = false
        
        init(isStationFetched: Bool) {
            self.isStationFetched = isStationFetched
        }
        
        func createStation(name: String) {
            isCreateStationCalled = true
        }
        
        func fetchStationByName(name: String) -> Station? {
            if isStationFetched {
                return Station()
            }
            return nil
        }
        
        func deleteStation(station: Station) {}
        func fetchAllStations() -> [Station] { return [] }
        
    }

    override func tearDownWithError() throws {
        sut = nil
        mockStationDataManager = nil
    }
    
    func test_addNewStation_createStationIsCalled() {
        // Given
        mockStationDataManager = MockStationDataManager(isStationFetched: false)
        sut = StationViewModel(name: "Test", stationDataManager: mockStationDataManager)
        
        // When
        sut.addNewStation()
        
        // Then
        XCTAssertTrue(mockStationDataManager.isCreateStationCalled)
    }
    
    func test_addNewStation_createStationIsNotCalled() {
        // Given
        mockStationDataManager = MockStationDataManager(isStationFetched: true)
        sut = StationViewModel(name: "Test", stationDataManager: mockStationDataManager)
        
        // When
        sut.addNewStation()
        
        // Then
        XCTAssertFalse(mockStationDataManager.isCreateStationCalled)
    }

}
