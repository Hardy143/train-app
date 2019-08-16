//
//  JsonParser.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/08/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct Welcome: Codable {
    let help: String
    let success: Bool
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let fields: [Field]
    let resourceID: [String]
    let limit: Int
    let total: String
    let records: [Record]
    
    enum CodingKeys: String, CodingKey {
        case fields
        case resourceID = "resource_id"
        case limit, total, records
    }
}

// MARK: - Field
struct Field: Codable {
    let id: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case float = "float"
    case text = "text"
}

// MARK: - Record
struct Record: Codable {
    let name, station, x, y: String
    let id: String
    let recordOperator: Operator
    let railway, publicTra: PublicTra
    let ref: String
    let network: Network
    let feedsFlatstoreEntryID, timestamp, feedsEntityID: String
    
    enum CodingKeys: String, CodingKey {
        case name, station
        case x = "X"
        case y = "Y"
        case id = "@id"
        case recordOperator = "operator"
        case railway
        case publicTra = "public_tra"
        case ref, network
        case feedsFlatstoreEntryID = "feeds_flatstore_entry_id"
        case timestamp
        case feedsEntityID = "feeds_entity_id"
    }
}

enum Network: String, Codable {
    case empty = ""
    case enterprise = "Enterprise"
    case nir = "NIR"
}

enum PublicTra: String, Codable {
    case empty = ""
    case station = "station"
}

enum Operator: String, Codable {
    case irishRail = "Irish Rail"
    case translinkNIRailways = "Translink NI Railways"
}

class JsonParser {
    
    func fetchRailwayStationsFromAPI(completion: @escaping ([String]) -> Void) {
        guard let railwayURL = URL(string: TrainAPIEndpoints.allStations) else { return }
        URLSession.shared.dataTask(with: railwayURL) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let railwayData = try decoder.decode(Welcome.self, from: data)
                let stations = railwayData.result.records
                let stationNames = self.getStationNames(stationNames: stations)
                completion(stationNames)
            } catch {
                print("error: \(error)")
            }
        }.resume()
    }
    
    private func getStationNames(stationNames: [Record]) -> [String] {
        var names: [String] = []
        for station in stationNames {
            names.append(station.name)
        }
        return names
    }
    
}
