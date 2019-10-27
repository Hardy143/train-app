//
//  TimeTableItemViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class TimeTableCollectionViewModel {
    
    private let apiUrl: String
    private let parser: Parser
    var timeTableItems: [TimeTableItem] = []
    
    init(apiUrl: String, parser: Parser = Parser()) {
        self.apiUrl = apiUrl
        self.parser = parser
    }
    
    func parseUrl(completion: @escaping ([TimeTableItem]) -> Void) {
        let url = TrainAPIEndpoints.getAPI(stationName: apiUrl)
        parser.parse(url: url) { timeTableData in
            self.timeTableItems = timeTableData
            completion(timeTableData)
        }
    }
    
}
