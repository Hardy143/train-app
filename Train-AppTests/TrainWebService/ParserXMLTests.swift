//
//  ParserXMLTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 31/01/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class ParserXMLTests: XCTestCase {
    
    var sut: ParserXML!
    let mockURL = "https://run.mocky.io/v3/dad20db2-d79f-4a43-b725-522e2feb868d"
    var timeTableItems: [TimeTableItem] = []

    override func setUpWithError() throws {
        sut = ParserXML()
    }

    override func tearDownWithError() throws {
        sut = nil
        timeTableItems = []
    }

    func test_parse_timeTableItemCountIs1() {
        // Given
        let expected = 1
        let expection = expectation(description: "test parse")
        var actual: [TimeTableItem] = []
        
        // When
        sut.parse(url: mockURL) { timeTableItems in
            actual = timeTableItems
            expection.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("test failed with error: \(error)")
            }
            XCTAssertEqual(expected, actual.count)
        }
    }
    
    func test_parse_destinationIsPortadown() {
        // Given
        let expected = "Destination: Portadown"
        let expection = expectation(description: "test destination")
        
        // When
        sut.parse(url: mockURL) { timeTableItems in
            self.timeTableItems = timeTableItems
            expection.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("test failed with error: \(error)")
            }
            
            guard let actual = self.timeTableItems.first?.destination else {
                XCTFail("destination is nil")
                return
            }
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func test_parse_departTimeIs20210131112500() {
        // Given
        let expected = "20210131112500"
        let expection = expectation(description: "test depart time")
        
        // When
        sut.parse(url: mockURL) { timeTableItems in
            self.timeTableItems = timeTableItems
            expection.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("test failed with error: \(error)")
            }
            
            guard let actual = self.timeTableItems.first?.departTime else {
                XCTFail("depart time is nil")
                return
            }
            
            XCTAssertEqual(expected, actual)
        }
    }
    
    func test_parse_platformIs3() {
        // Given
        let expected = "3"
        let expection = expectation(description: "test platform")
        
        // When
        sut.parse(url: mockURL) { timeTableItems in
            self.timeTableItems = timeTableItems
            expection.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("test failed with error: \(error)")
            }
            
            guard let actual = self.timeTableItems.first?.platform else {
                XCTFail("platform is nil")
                return
            }
            
            XCTAssertEqual(expected, actual)
        }
    }
    
}
