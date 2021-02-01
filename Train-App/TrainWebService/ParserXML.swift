//
//  Parser.swift
//  Train-App
//
//  Created by Vicki Larkin on 12/01/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

struct TrainXMLFile {
    
    struct Elements {
        static let stationBoard = "StationBoard"
        static let service = "Service"
        static let serviceType = "ServiceType"
        static let departTime = "DepartTime"
        static let platform = "Platform"
        static let destination = "Destination1"
    }
    
    struct Attributes {
        static let stationName = "name"
        static let type = "Type"
        static let time = "sorttimestamp"
        static let number = "Number"
        static let destinationName = "name"
    }
}

// Download xml from a server
// Parse XML to object
// Call back
// Add into table view
class ParserXML: NSObject, Parser {
    
    private var timeTableItems: [TimeTableItem] = []
    private var currentElement = ""
    private var currentStation = ""
    private var currentDepartTime = ""
    private var currentPlatform = ""
    private var currentDestination = ""
    private var isOrigin = false
    
    func parse(url: String, completion: @escaping ([Any]) -> Void) {
        
        guard let api = URL(string: url) else { return }
        
        let request = URLRequest(url: api)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            let timeTableData = self.timeTableItems
            completion(timeTableData)
        }
        
        task.resume()

    }
}

// MARK: - XML Parser Delegate

extension ParserXML: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        setCurrentStation(currentElement: currentElement, attributeDict: attributeDict)
        setIsOrigin(currentElement: currentElement, attributeDict: attributeDict)
        
        if isOrigin {
            setDepartureProperties(currentElement: currentElement, attributeDict: attributeDict)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard elementName == TrainXMLFile.Elements.service else { return }
        
        let timeTableItem = TimeTableItem(destination: currentDestination, departTime: currentDepartTime, platform: currentPlatform)
        if timeTableItem.departTime != "" {
            self.timeTableItems.append(timeTableItem)
            resetCurrentData()
        }
    }
    
}

// MARK: - Private Methods for Parsing

extension ParserXML {
    
    private func setCurrentStation(currentElement: String, attributeDict: [String : String]) {
        guard currentElement == TrainXMLFile.Elements.stationBoard else { return }
        
        if let station = attributeDict[TrainXMLFile.Attributes.stationName] {
            currentStation = station
        }
    }
    
    private func setIsOrigin(currentElement: String, attributeDict: [String : String]) {
        guard currentElement == TrainXMLFile.Elements.serviceType else { return }
        
        isOrigin = attributeDict[TrainXMLFile.Attributes.type] != "Terminating"
    }
    
    private func setDepartureProperties(currentElement: String, attributeDict: [String : String]) {
        
        switch currentElement {
        case TrainXMLFile.Elements.departTime:
            if let departTime = attributeDict[TrainXMLFile.Attributes.time] {
                currentDepartTime = departTime
            }
        case TrainXMLFile.Elements.platform:
            if let platform = attributeDict[TrainXMLFile.Attributes.number] {
                currentPlatform = platform
            }
        case TrainXMLFile.Elements.destination:
            if let destination = attributeDict[TrainXMLFile.Attributes.destinationName] {
                currentDestination = "Destination: \(destination)"
            }
        default:
            break
        }
    }
    
    private func resetCurrentData() {
        currentElement = ""
        currentStation = ""
        currentDepartTime = ""
        currentPlatform = ""
        currentDestination = ""
    }
}
