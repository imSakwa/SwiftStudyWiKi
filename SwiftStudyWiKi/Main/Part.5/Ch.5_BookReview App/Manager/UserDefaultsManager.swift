//
//  UserDefaultsManager.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/10.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    func getReview() -> [BookReview]
    func setReview(_ review: BookReview)
    
}

struct UserDefaultsManager: UserDefaultsManagerProtocol {
    enum Key: String {
        case review
    }
    
    func getReview() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        
        return (try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? []
    }
    
    func setReview(_ review: BookReview) {
        var currentReviews: [BookReview] = getReview()
        currentReviews.insert(review, at: 0)
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
    }
    
    
}
