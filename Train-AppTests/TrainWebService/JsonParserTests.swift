//
//  JsonParserTests.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 01/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class JsonParserTests: XCTestCase {
    
    var sut: JsonParser!
    let mockUrl = "https://run.mocky.io/v3/4e660529-94fc-4ceb-8843-5059dd08c4ab"
    let deleteMockURLLink = "https://designer.mocky.io/manage/delete/4e660529-94fc-4ceb-8843-5059dd08c4ab/SiSg6Q2uC6oEv9KPXkJKgidCcCkKGrIJDptZ"

    override func setUpWithError() throws {
        sut = JsonParser()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetchRailwayStationsFromAPI_countIs58() {
        // Given
        let expected = 58
        var testStations: [String] = []
        let fetchExpectation = expectation(description: "fetch railway stations")
        
        // When
        sut.parse(url: mockUrl) { stations in
            guard let stations = stations as? [String] else { return }
            testStations = stations
            fetchExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 3.0) { error in
            if let error = error {
                XCTFail("test failed with error: \(error)")
            }
            
            let actual = testStations.count
            XCTAssertEqual(expected, actual)
        }
    }

}
