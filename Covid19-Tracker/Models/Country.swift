//
//  Country.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

struct Country: Codable {
    
    var country: String
    var countryInfo: CountryInfo
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
//    var continent: String

    struct CountryInfo: Codable {
        var id: Int?
        var iso3: String?
        var lat: Double
        var long: Double
        var flag: String
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case iso3 = "iso3"
            case lat = "lat"
            case long = "long"
            case flag = "flag"
        }
    }
    
    func numbersByPropertyName(name: String) -> Int {
        switch name {
            case "cases":
                return cases
            case "todayCases":
                return todayCases
            case "deaths":
                return deaths
            case "todayDeaths":
                return todayDeaths
            case "recovered":
                return recovered
            case "active":
                return active
            case "critical":
                return critical
            default:
                fatalError("Could not access property name")
        }
    }
}
