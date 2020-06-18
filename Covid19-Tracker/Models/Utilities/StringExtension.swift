//
//  StringExtension.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-06-05.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import Foundation

extension String {
    func truncate(maxLength: Int, trailing: String = "...") -> String {
        if self.count <= maxLength {
            return self
        }
        
        var truncated = self.prefix(maxLength)
        
        while truncated.last != " " {
            truncated = truncated.dropLast()
        }
        
        return truncated + trailing
    }
    

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        return date
    }
    
    //converts string, to date, and back to string
    func convertToStringDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
}
