//
//  BookReview.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/10.
//

import Foundation

struct BookReview: Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}
