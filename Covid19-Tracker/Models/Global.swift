//
//  Global.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-04.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

struct Global: Codable {
    var cases: Int
    var todayCases: Int
    var deaths: Int
    var todayDeaths: Int
    var recovered: Int
    var active: Int
    var critical: Int
    var affectedCountries: Int
}

