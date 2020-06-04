//
//  Flag.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-01.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

func getFlag(country: Country) -> String {
    var flag = ""
    if let iso3 = country.countryInfo.iso3 {
        flag = IsoCountryCodes.find(key: iso3)?.flag ?? ""
    }
    return flag
}


