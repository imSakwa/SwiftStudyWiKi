//
//  BookSearchRequestModel.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/10.
//

import Foundation

struct BookSearchRequestModel: Codable {
    /// 검색할 키워드
    let query: String
}
