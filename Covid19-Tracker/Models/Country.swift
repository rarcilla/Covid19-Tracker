//
//  Country.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-03.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

struct Country: Codable, Identifiable {
    var id = UUID()
    var countryName: String
    var countryInfo: CountryInfo
    var cases: Int?
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?
    var recovered: Int?
    var active: Int?
    var critical: Int?
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country"
        case countryInfo
        case cases
        case todayCases
        case deaths
        case todayDeaths
        case recovered
        case active
        case critical
    }

    struct CountryInfo: Codable {
        var countryInfoID: Int?
        var iso3: String?
        var lat: Double
        var long: Double
        var flag: String
        
        enum CodingKeys: String, CodingKey {
            case countryInfoID = "_id"
            case iso3 = "iso3"
            case lat = "lat"
            case long = "long"
            case flag = "flag"
        }
    }
    
    func numbersByPropertyName(name: String) -> Int {
        switch name {
            case "cases":
                return cases ?? 0
            case "todayCases":
                return todayCases ?? 0
            case "deaths":
                return deaths ?? 0
            case "todayDeaths":
                return todayDeaths ?? 0
            case "recovered":
                return recovered ?? 0
            case "active":
                return active ?? 0
            case "critical":
                return critical ?? 0
            default:
                fatalError("Could not access property name")
        }
    }
}
