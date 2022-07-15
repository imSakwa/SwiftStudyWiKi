//
//  MovieListPresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/15.
//

import Foundation

protocol MovieListProtocol: AnyObject {
    func setNavigationBar()
}

final class MovieListPresenter {
    
    private weak var viewController: MovieListProtocol?
    
    init(viewController: MovieListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setNavigationBar()
    }
}
