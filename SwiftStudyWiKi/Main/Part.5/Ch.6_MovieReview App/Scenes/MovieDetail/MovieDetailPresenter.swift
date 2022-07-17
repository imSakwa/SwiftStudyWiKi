//
//  MovieDetailPresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/16.
//

import Foundation

protocol MovieDetailProtocol: AnyObject {
    func setViews(with movie: Movie)
    func setRightBarButton(with isLiked: Bool)
//    func didTapRightBarButtonItem()
}

final class MovieDetailPresenter: NSObject {
    private weak var viewController: MovieDetailProtocol?
    
    private let userDefaultManager: MovieUserDefaultsManagerProtocol
    
    private var movie: Movie
    init(
        viewController: MovieDetailProtocol,
        movie: Movie,
        userDefaultsManager: MovieUserDefaultsManagerProtocol = MovieUserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movie = movie
        self.userDefaultManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setViews(with: self.movie)
        viewController?.setRightBarButton(with: movie.isLiked)
    }
    
    func didTapRightBarButtonItem() {
        movie.isLiked.toggle()
        
        if movie.isLiked {
            userDefaultManager.addMovie(movie)
        } else {
            userDefaultManager.removeMovie(movie)
        }
        
        viewController?.setRightBarButton(with: movie.isLiked)
    }
}
