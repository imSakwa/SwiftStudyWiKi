//
//  Alert.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/08.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var time: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "a"
        timeFormatter.locale = Locale(identifier: "ko")
        return timeFormatter.string(from: date)
    }
}
