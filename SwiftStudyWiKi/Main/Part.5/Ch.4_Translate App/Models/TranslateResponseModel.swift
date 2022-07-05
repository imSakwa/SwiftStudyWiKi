//
//  TranslateResponseModel.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/06.
//

import Foundation

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText }
    
    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String
    }
}
