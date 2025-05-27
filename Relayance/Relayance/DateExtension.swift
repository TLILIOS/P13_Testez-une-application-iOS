//
//  DateExtension.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

extension Date {
    static func dateFromString(_ isoString: String) -> Date? {
        // Try with the specific format used in tests
        let exactFormatter = DateFormatter()
        exactFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        exactFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = exactFormatter.date(from: isoString) {
            return date
        }
        
        // If that fails, try with simple date format
        let simpleDateFormatter = DateFormatter()
        simpleDateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = simpleDateFormatter.date(from: isoString) {
            return date
        }
        
        // Finally, try ISO8601 format
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime]
        
        return isoDateFormatter.date(from: isoString)
    }
    
    static func stringFromDate(_ date: Date) -> String? {
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "dd-MM-yyyy"
        return isoDateFormatter.string(from: date)
    }
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonth() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
}
