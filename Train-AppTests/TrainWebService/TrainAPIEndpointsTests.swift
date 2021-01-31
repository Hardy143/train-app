//
//  TrainAPIEndpoints.swift
//  Train-AppTests
//
//  Created by Vicki Larkin on 31/01/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import XCTest
@testable import Train_App

class TrainAPIEndpointsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getAPI_BangorIsReturned() {
        // Given
        let expected = "https://apis.opendatani.gov.uk/translink/3042A7.xml"
        let testStation = "Bangor"
        
        // When
        let actual = TrainAPIEndpoints.getAPI(stationName: testStation)
        
        // Then
        XCTAssertEqual(expected, actual)
    }
    
    func test_getAPI_emptyStringIsReturned() {
        // Given
        let expected = ""
        let testStation = "Australia"
        
        // When
        let actual = TrainAPIEndpoints.getAPI(stationName: testStation)
        
        // Then
        XCTAssertEqual(expected, actual)
    }

}
