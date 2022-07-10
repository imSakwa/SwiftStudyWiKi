//
//  Book.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/10.
//

import Foundation

struct Book: Decodable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: image ?? "") }
}
