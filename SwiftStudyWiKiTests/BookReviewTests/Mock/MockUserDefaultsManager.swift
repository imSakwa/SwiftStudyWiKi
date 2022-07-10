//
//  MockUserDefaultsManager.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/10.
//

import Foundation
@testable import SwiftStudyWiKi

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isCalledGetReviews = false
    var isCalledSetReview = false
    
    func getReview() -> [BookReview] {
        isCalledGetReviews = true
        return []
    }
    
    func setReview(_ review: BookReview) {
        isCalledSetReview = true
    }
}
