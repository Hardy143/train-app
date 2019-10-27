//
//  StationViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 26/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class StationViewModel {
    
    let name: String
    private let stationDataManager: StationDataManager
    
    init(name: String, stationDataManager: StationDataManager = StationDataManager()) {
        self.name = name
        self.stationDataManager = stationDataManager
    }
    
    func addNewStation() {
        if !isStationAlreadyAdded() {
            stationDataManager.createStation(name: self.name)
        }
    }
    
    private func isStationAlreadyAdded() -> Bool {
        if stationDataManager.fetchStationByName(name: name) != nil {
            return true
        }
        return false
    }
}
