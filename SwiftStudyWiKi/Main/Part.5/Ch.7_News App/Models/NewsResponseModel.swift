//
//  NewsResponseModel.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/24.
//

import Foundation

struct NewsResponseModel: Decodable {
    var items: [News] = []
}

struct News: Decodable {
    let title: String
    let link: String
    let description: String
    let pubDate: String
}
