//
//  TimeTableItemViewModelTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 01/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class TimeTableItemViewModelTests: XCTestCase {
    
    var sut: TimeTableItemViewModel!
    let testTimeTableItem = TimeTableItem(destination: "Belfast", departTime: "20210201221500", platform: "3")

    override func setUpWithError() throws {
        sut = TimeTableItemViewModel(timeTableItem: testTimeTableItem)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_destination_Belfast() {
        // Given
        let expected = "Belfast"
        
        // When
        let actual = sut.destination
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_platform_3() {
        // Given
        let expected = "3"
        
        // When
        let actual = sut.platform
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_departTime_1015() {
        // Given
        let expected = "10:15 PM"
        
        // When
        let actual = sut.departTime
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_departTime_emptyString() {
        // Given
        let expected = ""
        let testTimeTableItem = TimeTableItem(destination: "Belfast", departTime: "12345", platform: "3")
        sut = TimeTableItemViewModel(timeTableItem: testTimeTableItem)
        
        // When
        let actual = sut.departTime
        
        // Then
        XCTAssertEqual(expected, actual)
    }

}
