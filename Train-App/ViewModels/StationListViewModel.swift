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
    private let jsonParser: JsonParser
    
    init(stationDataManager: StationDataManager = StationDataManager(), jsonParser: JsonParser = JsonParser()) {
        self.stationDataManager = stationDataManager
        self.jsonParser = jsonParser
    }
    
    var stations: [StationViewModel] {
        return getListOfStations()
    }
    
    func getStations(completion: @escaping ([StationViewModel]) -> Void) {
        jsonParser.fetchRailwayStationsFromAPI { (names) in
            var stations: [StationViewModel] = []
            
            for name in names {
                let station = StationViewModel(name: name)
                stations.append(station)
            }
            
            completion(stations)
        }
    }
}

// MARK: - Private methods
extension StationListViewModel {
    
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
