//
//  RemoveStationListViewModel.swift
//  Train-App
//
//  Created by Vicki Larkin on 27/10/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

class RemoteStationListViewModel {
    
    private let jsonParser: JsonParser
    
    init(jsonParser: JsonParser = JsonParser()) {
        self.jsonParser = jsonParser
    }
    
    func getStations(completion: @escaping ([RemoteStation]) -> Void) {
        jsonParser.fetchRailwayStationsFromAPI { (names) in
            var stations: [RemoteStation] = []
            
            for name in names {
                let station = RemoteStation(name: name)
                stations.append(station)
            }
            
            completion(stations)
        }
    }
}
