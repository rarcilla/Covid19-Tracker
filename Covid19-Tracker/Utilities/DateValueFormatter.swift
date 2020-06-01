//
//  DateValueFormatter.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-21.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation
import Charts

//public class DateValueFormatter: NSObject, IAxisValueFormatter {
//    var dateFormatter: DateFormatter?
//    var referenceTimeInterval: TimeInterval?
////    private let dateFormatter = DateFormatter()
//
//    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
//        self.init()
//        self.referenceTimeInterval = referenceTimeInterval
//        self.dateFormatter = dateFormatter
////        dateFormatter.dateFormat = "MM/dd/yy"
//    }
//
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        guard let dateFormatter = self.dateFormatter, let referenceTimeInterval = self.referenceTimeInterval else {
//            return ""
//        }
//
//        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
//
//        return dateFormatter.string(from: date)
//    }
//}

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "dd MMM HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
