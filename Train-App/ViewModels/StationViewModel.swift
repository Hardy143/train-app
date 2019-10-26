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
    let stationDataManager: StationDataManager
    
    init(name: String, stationDataManager: StationDataManager = StationDataManager()) {
        self.name = name
        self.stationDataManager = stationDataManager
    }
    
    func addNewStation() {
        stationDataManager.createStation(name: self.name)
    }
}
