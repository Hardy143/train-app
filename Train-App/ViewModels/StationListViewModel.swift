//
//  StationListViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class StationListViewModel {
    
    private let stationDataManager: StationDataManager
    
    init(stationDataManager: StationDataManager = StationDataManager()) {
        self.stationDataManager = stationDataManager
    }
    
    var stations: [StationViewModel] {
        return getListOfStations()
    }
    
    private func getListOfStations() -> [StationViewModel] {
        var stations: [StationViewModel] = []
        let results = stationDataManager.fetchAllStations()
        
        for result in results {
            if let name = result.name {
                let stationViewModel = StationViewModel(name: name)
                stations.append(stationViewModel)
            }
        }
        
        return stations
    }
}
