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
        return ("\(minutes):\(remainingSeconds)")
    }
}
