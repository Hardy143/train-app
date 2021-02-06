//
//  TimeTableItemViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class DepartureListViewModel {
    
    private let xmlParser: Parser
    private let stationName: String
    
    init(stationName: String, parser: Parser = ParserXML()) {
        self.stationName = stationName
        self.xmlParser = parser
    }
    
    func parseUrl(completion: @escaping ([TimeTableItem]) -> Void) {
        let apiUrl = TrainAPIEndpoints.getAPI(stationName: stationName)
        
        xmlParser.parse(url: apiUrl) { timeTableData in
            guard let timeTableItems = timeTableData as? [TimeTableItem] else { return }
            completion(timeTableItems)
        }
    }
    
    func createTimeTableItem(destination: String, departTime: String, platform: String) -> TimeTableItemViewModel {
        let timeTableItem = TimeTableItem(destination: destination, departTime: departTime, platform: platform)
        
        return TimeTableItemViewModel(timeTableItem: timeTableItem)
    }
    
}
