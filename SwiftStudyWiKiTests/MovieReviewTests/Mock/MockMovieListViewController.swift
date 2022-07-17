//
//  MockMovieListViewController.swift
//  SwiftStudyWiKiTests
//
//  Created by ChangMin on 2022/07/17.
//

import Foundation
@testable import SwiftStudyWiKi


final class MockMovieListViewController: MovieListProtocol {
    var isCalledSetNavigationBar = false
    var isCalledSetupSearchBar = false
    var isCalledSetupViews = false
    var isCalledUpdateSearchTableView = false
    var isCalledPushToMovieDetailViewController = false
    var isCalledUpdateCollectionView = false
    
    func setNavigationBar() {
        isCalledSetNavigationBar = true
    }
    
    func setupSearchBar() {
        isCalledSetupSearchBar = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        isCalledUpdateSearchTableView = true
    }
    
    func pushToMovieDetailViewController(with movie: Movie) {
        isCalledPushToMovieDetailViewController = true
    }
    
    func updateCollectionView() {
        isCalledUpdateCollectionView = true
    }
}
