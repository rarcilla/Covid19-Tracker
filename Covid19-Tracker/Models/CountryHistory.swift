//
//  CountryHistory.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-07.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation
import Combine

struct CountryHistory: Codable {
    var timeline: Timeline
    
    struct Timeline: Codable {
        var cases: [String: Int]
        var deaths: [String: Int]
        var recovered: [String: Int]
    }
}
