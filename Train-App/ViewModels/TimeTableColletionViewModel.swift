//
//  TimeTableItemViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class TimeTableCollectionViewModel {
    
    private let parser: ParserXML
    var timeTableItems: [TimeTableItem] = []
    
    private let stationName: String
    
    init(stationName: String, parser: ParserXML = ParserXML()) {
        self.stationName = stationName
        self.parser = parser
    }
    
    var apiUrl: String {
        return TrainAPIEndpoints.getAPI(stationName: self.stationName)
    }
    
    func parseUrl(completion: @escaping ([TimeTableItem]) -> Void) {
        parser.parse(url: apiUrl) { timeTableData in
            self.timeTableItems = timeTableData
            completion(timeTableData)
        }
    }
    
}
