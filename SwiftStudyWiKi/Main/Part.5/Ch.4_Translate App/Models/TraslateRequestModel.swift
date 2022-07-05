//
//  TraslateRequestModel.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/06.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
