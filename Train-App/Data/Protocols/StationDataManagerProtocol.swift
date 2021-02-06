//
//  StationManagerProtocol.swift
//  Train-App
//
//  Created by Vicki Larkin on 06/02/2021.
//  Copyright © 2021 Vicki Hardy. All rights reserved.
//

import Foundation

protocol StationDataManagerProtocol {
    func createStation(name: String)
    func deleteStation(station: Station)
    func fetchAllStations() -> [Station]
    func fetchStationByName(name: String) -> Station?
}
