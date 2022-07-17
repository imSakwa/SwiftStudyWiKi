//
//  MockMovieDetailViewController.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/17.
//

import Foundation
@testable import SwiftStudyWiKi

final class MockMovieDetailViewController: MovieDetailProtocol {
    var isCalledsetViews = false
    var isCalledSetRightBarButton = false
    
    var settedIsLiked = false
    
    func setViews(with movie: Movie) {
        isCalledsetViews = true
    }
    
    func setRightBarButton(with isLiked: Bool) {
        settedIsLiked = isLiked
        
        isCalledSetRightBarButton = true
    }
}
