//
//  MockMovieSearchManager.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/17.
//

import Foundation
@testable import SwiftStudyWiKi

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var isCalledRequest = false
    var needToSuccessRequest = false
    
    func request(
        from keyword: String,
        completionHandler: @escaping (([Movie]) -> Void)
    ) {
        isCalledRequest = true
        
        if needToSuccessRequest {
            completionHandler([])
        }
    }
}
