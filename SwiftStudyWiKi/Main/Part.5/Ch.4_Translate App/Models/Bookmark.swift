//
//  Bookmark.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}

