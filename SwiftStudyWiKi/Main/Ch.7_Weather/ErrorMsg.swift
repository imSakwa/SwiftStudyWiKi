//
//  ErrorMsg.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/03.
//

import Foundation

struct ErrorMsg: Codable {
    let msg: String
    
    enum CodingKeys: String, CodingKey {
        case msg = "message"
    }
}
