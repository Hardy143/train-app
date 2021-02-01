//
//  DepartureListViewModelTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 01/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class DepartureListViewModelTests: XCTestCase {
    
    var sut: DepartureListViewModel!
    let testStation = "Bangor"
    var mockXMLParser: Parser!
    
    class MockXMLParser: Parser {
        
        func parse(url: String, completion: @escaping ([Any]) -> Void) {
            let test1 = TimeTableItem(destination: "Bangor", departTime: "202012345", platform: "1")
            let test2 = TimeTableItem(destination: "Belfast", departTime: "202012345", platform: "2")
            let test3 = TimeTableItem(destination: "Balymena", departTime: "202012345", platform: "3")
            
            let timeTableItems = [test1, test2, test3]
            
            completion(timeTableItems)
        }
        
    }

    override func setUpWithError() throws {
        mockXMLParser = MockXMLParser()
        sut = DepartureListViewModel(stationName: testStation, parser: mockXMLParser)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_parseUrl_countIs3() {
        // Given
        let expected = 3
        var result: [TimeTableItem] = []
        let parseExpectation = expectation(description: "parse")
        
        // When
        sut.parseUrl { timeTableItems in
            result = timeTableItems
            parseExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("failed with error: \(error)")
            }
            
            let actual = result.count
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func test_createTimeTableItem_destinationIsBangor() {
        // Given
        let expected = "Bangor"
        
        // When
        let result = sut.createTimeTableItem(destination: expected, departTime: "test", platform: "test")
        
        // Then
        let actual = result.destination
        XCTAssertEqual(expected, actual)
    }
    
    func test_createTimeTableItem_platformIs1() {
        // Given
        let expected = "1"
        
        // When
        let result = sut.createTimeTableItem(destination: "test", departTime: "test", platform: expected)
        
        // Then
        let actual = result.platform
        XCTAssertEqual(expected, actual)
    }
    
    func test_createTimeTableItem_departTimeIs12345() {
        // Given
        let mockTime = "20210201221500"
        let expected = "10:15 PM"
        
        // When
        let result = sut.createTimeTableItem(destination: "test", departTime: mockTime, platform: "test")
        
        // Then
        let actual = result.departTime
        XCTAssertEqual(expected, actual)
    }

}
