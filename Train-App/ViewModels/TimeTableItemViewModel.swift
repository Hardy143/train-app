//
//  TimeTableItemViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class TimeTableItemViewModel {
    
    private let timeTableItem: TimeTableItem
    
    init(timeTableItem: TimeTableItem) {
        self.timeTableItem = timeTableItem
    }
    
    var destination: String {
        return timeTableItem.destination
    }
    
    var platform: String {
        return timeTableItem.platform
    }
    
    var departTime: String {
        return formatDate(dateString: timeTableItem.departTime)
    }
}

// MARK: - Private methods
extension TimeTableItemViewModel {
    
    private func formatDate(dateString: String) -> String {
    
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyyMMddHHmmss"
    
        let dateFomatterConvert = DateFormatter()
        dateFomatterConvert.dateFormat = "h:mm a"
        
        guard let date = dateFormatterGet.date(from: dateString) else {
            print("Error formatting date")
            return ""
        }
        
        return dateFomatterConvert.string(from: date)
        
    }
    
}
