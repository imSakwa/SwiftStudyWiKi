//
//  MockMovieUserDefualtsManager.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/17.
//

import Foundation
@testable import SwiftStudyWiKi

final class MockMovieUserDefualtsManager: MovieUserDefaultsManagerProtocol {
    var isCalledGetMovies = false
    var isCalledAddMovie = false
    var isCalledRemoveMovie = false
    
    func getMovies() -> [Movie] {
        isCalledGetMovies = true
        return []
    }
    
    func addMovie(_ newValue: Movie) {
        isCalledAddMovie = true
    }
    
    func removeMovie(_ value: Movie) {
        isCalledRemoveMovie = true
    }
}
