//
//  TrainAPIEndpoints.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/03/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

struct TrainAPIEndpoints {
    static let adelaide = "https://apis.opendatani.gov.uk/translink/3042A0.xml"
    static let antrim = "https://apis.opendatani.gov.uk/translink/3042A1.xml"
    static let ballycarry = "https://apis.opendatani.gov.uk/translink/3042A3.xml"
    static let ballymena = "https://apis.opendatani.gov.uk/translink/3042A2.xml"
    static let ballymoney = "https://apis.opendatani.gov.uk/translink/3042AA.xml"
    static let balmoral = "https://apis.opendatani.gov.uk/translink/3042A5.xml"
    static let bangor = "https://apis.opendatani.gov.uk/translink/3042A7.xml"
    static let bangorWest = "https://apis.opendatani.gov.uk/translink/3042A9.xml"
    static let belfastCentral = "https://apis.opendatani.gov.uk/translink/3043AF.xml"
    static let bellarena = "https://apis.opendatani.gov.uk/translink/3042A6.xml"
    static let botanic = "https://apis.opendatani.gov.uk/translink/3042A8.xml"
    static let carnalea = "https://apis.opendatani.gov.uk/translink/3042AB.xml"
    static let carrickfergus = "https://apis.opendatani.gov.uk/translink/3043B1.xml"
    static let castlerock = "https://apis.opendatani.gov.uk/translink/3042AE.xml"
    static let cityHospital = "https://apis.opendatani.gov.uk/translink/3042AD.xml"
    static let clipperstown = "https://apis.opendatani.gov.uk/translink/3043B0.xml"
    static let coleraine = "https://apis.opendatani.gov.uk/translink/3042AC.xml"
    static let cullybackey = "https://apis.opendatani.gov.uk/translink/3043B3.xml"
    static let cultra = "https://apis.opendatani.gov.uk/translink/3043B2.xml"
    static let derriaghy = "https://apis.opendatani.gov.uk/translink/3043B5.xml"
    static let dhuVarren = "https://apis.opendatani.gov.uk/translink/3043BA.xml"
    static let downshire = "https://apis.opendatani.gov.uk/translink/3043B9.xml"
    static let dogheda = "https://apis.opendatani.gov.uk/translink/3043B4.xml"
    static let dublinConnolly = "https://apis.opendatani.gov.uk/translink/3043B8.xml"
    static let dundalk = "https://apis.opendatani.gov.uk/translink/3043B6.xml"
    static let dunmurray = "https://apis.opendatani.gov.uk/translink/3043B7.xml"
    static let finaghy = "https://apis.opendatani.gov.uk/translink/3043BB.xml"
    static let glynn = "https://apis.opendatani.gov.uk/translink/3044BD.xml"
    static let greatVictoriaSt = "https://apis.opendatani.gov.uk/translink/3044BE.xml"
    static let greenisland = "https://apis.opendatani.gov.uk/translink/3043BC.xml"
    static let helensBay = "https://apis.opendatani.gov.uk/translink/3044BF.xml"
    static let hilden = "https://apis.opendatani.gov.uk/translink/3044C0.xml"
    static let holywood = "https://apis.opendatani.gov.uk/translink/3044C1.xml"
    static let jordanstown = "https://apis.opendatani.gov.uk/translink/3044C2.xml"
    static let lambeg = "https://apis.opendatani.gov.uk/translink/3044C4.xml"
    static let larneHarbour = "https://apis.opendatani.gov.uk/translink/3044C6.xml"
    static let lisburn = "https://apis.opendatani.gov.uk/translink/3044C3.xml"
    static let londonderry = "https://apis.opendatani.gov.uk/translink/3044C8.xml"
    static let lurgan = "https://apis.opendatani.gov.uk/translink/3044C7.xml"
    static let magheramorne = "https://apis.opendatani.gov.uk/translink/3044C9.xml"
    static let marino = "https://apis.opendatani.gov.uk/translink/3044CA.xml"
    static let moira = "https://apis.opendatani.gov.uk/translink/3045CB.xml"
    static let mossleyWest = "https://apis.opendatani.gov.uk/translink/3045CC.xml"
    static let newry = "https://apis.opendatani.gov.uk/translink/3045CD.xml"
    static let portadown = "https://apis.opendatani.gov.uk/translink/3045CE.xml"
    static let portrush = "https://apis.opendatani.gov.uk/translink/3045CF.xml"
    static let poyntzpass = "https://apis.opendatani.gov.uk/translink/3045D0.xml"
    static let scarva = "https://apis.opendatani.gov.uk/translink/3045D1.xml"
    static let seahill = "https://apis.opendatani.gov.uk/translink/3045D2.xml"
    static let sydenham = "https://apis.opendatani.gov.uk/translink/3045D3.xml"
    static let titanicQuarter = "https://apis.opendatani.gov.uk/translink/3042A4.xml"
    static let tropperslane = "https://apis.opendatani.gov.uk/translink/3045D4.xml"
    static let university = "https://apis.opendatani.gov.uk/translink/3045D5.xml"
    static let whiteabbey = "https://apis.opendatani.gov.uk/translink/3045D7.xml"
    static let whitehead = "https://apis.opendatani.gov.uk/translink/3045D6.xml"
    static let yorkgate = "https://apis.opendatani.gov.uk/translink/3045D8.xml"
    
    static let apis: [String: String] = [
        "Adelaide": "https://apis.opendatani.gov.uk/translink/3042A0.xml",
        "Bangor": "https://apis.opendatani.gov.uk/translink/3042A7.xml"]
    
    static let allStations = "https://data.nicva.org/api/action/datastore/search.json?resource_id=ef0a44e9-3edb-4f0b-b37d-9cc07d67553c"
    
    static func getAPI(stationName: String) -> String {
        var api = ""
        for (key, value) in apis {
            if stationName == key {
                api = value
            }
        }
        
        return api
    }
}


