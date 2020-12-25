//
//  DateFormat.swift
//  YinzCamProject
//
//  Created by Dambar Bista on 12/20/20.
//

import Foundation

struct DateFormat {
    
    static func convertDateFormater(from date: Date) -> String {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEE, MMM d"
        dateFormater.timeZone = TimeZone.current
        
        let timeStamp = dateFormater.string(from: date)
        
        return timeStamp
    }
}






