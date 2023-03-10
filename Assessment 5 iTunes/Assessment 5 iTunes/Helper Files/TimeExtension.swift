//
//  TimeExtension.swift
//  Assessment 5 iTunes
//
//  Created by Chase on 3/9/23.
//

import Foundation

struct Converter {
    
    static func millisecondsToMinutesAndSeconds(milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let minutes = totalSeconds / 60
        let remainingSeconds = totalSeconds % 60
        return "\(minutes):" + String(format: "%02d", remainingSeconds) // %02d should print with at least 2 characters and have a leading zero if necessary
    }
}
