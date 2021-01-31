//
//  TrainAPIEndpoints.swift
//  Train-App
//
//  Created by Vicki Larkin on 16/03/2019.
//  Copyright © 2019 Vicki Hardy. All rights reserved.
//

import Foundation

struct TrainAPIEndpoints {
    
    static let apis: [String: String] = [
        "Adelaide" : "https://apis.opendatani.gov.uk/translink/3042A0.xml",
        "Antrim" : "https://apis.opendatani.gov.uk/translink/3042A1.xml",
        "Ballycarry" : "https://apis.opendatani.gov.uk/translink/3042A3.xml",
        "Ballymena" : "https://apis.opendatani.gov.uk/translink/3042A2.xml",
        "Ballymoney" : "https://apis.opendatani.gov.uk/translink/3042AA.xml",
        "Balmoral" : "https://apis.opendatani.gov.uk/translink/3042A5.xml",
        "Bangor" : "https://apis.opendatani.gov.uk/translink/3042A7.xml",
        "Bangor West" : "https://apis.opendatani.gov.uk/translink/3042A9.xml",
        "Belfast Central" : "https://apis.opendatani.gov.uk/translink/3043AF.xml",
        "Bllarena" : "https://apis.opendatani.gov.uk/translink/3042A6.xml",
        "Botanic" : "https://apis.opendatani.gov.uk/translink/3042A8.xml",
        "Carnalea" : "https://apis.opendatani.gov.uk/translink/3042AB.xml",
        "Carrickfergus" : "https://apis.opendatani.gov.uk/translink/3043B1.xml",
        "Castlerock" : "https://apis.opendatani.gov.uk/translink/3042AE.xml",
        "City Hospital" : "https://apis.opendatani.gov.uk/translink/3042AD.xml",
        "Clipperstown" : "https://apis.opendatani.gov.uk/translink/3043B0.xml",
        "Coleraine" : "https://apis.opendatani.gov.uk/translink/3042AC.xml",
        "Cullybackey" : "https://apis.opendatani.gov.uk/translink/3043B3.xml",
        "Cultra" : "https://apis.opendatani.gov.uk/translink/3043B2.xml",
        "Derriaghy" : "https://apis.opendatani.gov.uk/translink/3043B5.xml",
        "Dhu Varren" : "https://apis.opendatani.gov.uk/translink/3043BA.xml",
        "Downshire" : "https://apis.opendatani.gov.uk/translink/3043B9.xml",
        "Dogheda" : "https://apis.opendatani.gov.uk/translink/3043B4.xml",
        "Dublin Connolly" : "https://apis.opendatani.gov.uk/translink/3043B8.xml",
        "Dundalk" : "https://apis.opendatani.gov.uk/translink/3043B6.xml",
        "Dunmurray" : "https://apis.opendatani.gov.uk/translink/3043B7.xml",
        "Finaghy" : "https://apis.opendatani.gov.uk/translink/3043BB.xml",
        "Glynn" : "https://apis.opendatani.gov.uk/translink/3044BD.xml",
        "Belf - Great Victoria Street" : "https://apis.opendatani.gov.uk/translink/3044BE.xml",
        "Greenisland" : "https://apis.opendatani.gov.uk/translink/3043BC.xml",
        "Helens Bay" : "https://apis.opendatani.gov.uk/translink/3044BF.xml",
        "Hilden" : "https://apis.opendatani.gov.uk/translink/3044C0.xml",
        "Holywood" : "https://apis.opendatani.gov.uk/translink/3044C1.xml",
        "Jordanstown" : "https://apis.opendatani.gov.uk/translink/3044C2.xml",
        "Lambeg" : "https://apis.opendatani.gov.uk/translink/3044C4.xml",
        "Larne Harbour" : "https://apis.opendatani.gov.uk/translink/3044C6.xml",
        "Lisburn" : "https://apis.opendatani.gov.uk/translink/3044C3.xml",
        "Londonderry" : "https://apis.opendatani.gov.uk/translink/3044C8.xml",
        "Lurgan" : "https://apis.opendatani.gov.uk/translink/3044C7.xml",
        "Magheramorne" : "https://apis.opendatani.gov.uk/translink/3044C9.xml",
        "Marino" : "https://apis.opendatani.gov.uk/translink/3044CA.xml",
        "Moira" : "https://apis.opendatani.gov.uk/translink/3045CB.xml",
        "Mossley West" : "https://apis.opendatani.gov.uk/translink/3045CC.xml",
        "Newry" : "https://apis.opendatani.gov.uk/translink/3045CD.xml",
        "Portadown" : "https://apis.opendatani.gov.uk/translink/3045CE.xml",
        "Portrush" : "https://apis.opendatani.gov.uk/translink/3045CF.xml",
        "Poyntzpass" : "https://apis.opendatani.gov.uk/translink/3045D0.xml",
        "Scarva" : "https://apis.opendatani.gov.uk/translink/3045D1.xml",
        "Seahill" : "https://apis.opendatani.gov.uk/translink/3045D2.xml",
        "Sydenham" : "https://apis.opendatani.gov.uk/translink/3045D3.xml",
        "Titanic Quarter" : "https://apis.opendatani.gov.uk/translink/3042A4.xml",
        "Tropperslane" : "https://apis.opendatani.gov.uk/translink/3045D4.xml",
        "University" : "https://apis.opendatani.gov.uk/translink/3045D5.xml",
        "Whiteabbey" : "https://apis.opendatani.gov.uk/translink/3045D7.xml",
        "Whitehead" : "https://apis.opendatani.gov.uk/translink/3045D6.xml",
        "Yorkgate" : "https://apis.opendatani.gov.uk/translink/3045D8.xml"]
    
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


