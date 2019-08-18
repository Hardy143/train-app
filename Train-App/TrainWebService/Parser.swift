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
        let stationBoard = "StationBoard"
        let service = "Service"
        let serviceType = "ServiceType"
        let departTime = "DepartTime"
        let platform = "Platform"
        let destination = "Destination1"
    }
    
    struct Attributes {
        let stationName = "name"
        let type = "Type"
        let time = "sorttimestamp"
        let number = "Number"
        let destinationName = "name"
    }
}

// Download xml from a server
// Parse XML to object
// Call back
// Add into table view
class Parser: NSObject {
    
    private var timeTableItems: [TimeTableItem] = []
    private var currentElement = ""
    private var currentStation = ""
    private var currentDepartTime = ""
    private var currentPlatform = ""
    private var currentDestination = ""
    private var parserCompletionHandler: (([TimeTableItem]) -> Void)?
    private var isOrigin = false
    
    
    func parse(url: String, completionHandler: @escaping ([TimeTableItem]) -> Void) {
        
        //self.parserCompletionHandler = completionHandler
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
            completionHandler(timeTableData)
        }
        
        task.resume()

    }
}

extension Parser: XMLParserDelegate {
    
    //MARK: XML Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == TrainXMLFile.Elements().stationBoard {
            if let station = attributeDict[TrainXMLFile.Attributes().stationName] {
                currentStation = station
            }
        }
        
        if currentElement == TrainXMLFile.Elements().serviceType {
            if attributeDict[TrainXMLFile.Attributes().type] == "Originating" ||
                attributeDict[TrainXMLFile.Attributes().type] == "Through" {
                isOrigin = true
            } else {
                isOrigin = false
            }
        }
        
        if isOrigin {
            
            switch currentElement {
            case TrainXMLFile.Elements().departTime:
                if let departTime = attributeDict[TrainXMLFile.Attributes().time] {
                    currentDepartTime = departTime
                }
            case TrainXMLFile.Elements().platform:
                if let platform = attributeDict[TrainXMLFile.Attributes().number] {
                    currentPlatform = platform
                }
            case TrainXMLFile.Elements().destination:
                if let destination = attributeDict[TrainXMLFile.Attributes().destinationName] {
                    currentDestination = "Destination: \(destination)"
                }
            default:
                break
            }
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == TrainXMLFile.Elements().service {
            let timeTableItem = TimeTableItem(destination: currentDestination, departTime: currentDepartTime, platform: currentPlatform)
            if timeTableItem.departTime != "" {
                self.timeTableItems.append(timeTableItem)
                resetCurrentData()
            }
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
