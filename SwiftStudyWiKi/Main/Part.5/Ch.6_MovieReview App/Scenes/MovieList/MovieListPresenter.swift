//
//  MovieListPresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/15.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setNavigationBar()
    func setupSearchBar()
    func setupViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieDetailViewController(with movie: Movie)
    func updateCollectionView()
}

final class MovieListPresenter: NSObject {
    private weak var viewController: MovieListProtocol?
    
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private let userDefaultsManager: MovieUserDefaultsManagerProtocol
    
    private var likedMovie: [Movie] = []
    
    private var currentMovieSearchResult: [Movie] = []
    
    init(
        viewController: MovieListProtocol,
        movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager(),
        userDefaultsManager: MovieUserDefaultsManagerProtocol = MovieUserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefaultsManager.getMovies()
        
        viewController?.updateCollectionView()
    }
}

extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.request(from: searchText) { [weak self] movies in
            
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        
        return CGSize(width: width, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell
        
        let movie = likedMovie[indexPath.row]
        cell?.update(movie)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = likedMovie[indexPath.row]
        
        viewController?.pushToMovieDetailViewController(with: movie)
    }
}

extension MovieListPresenter: UITableViewDelegate {
}

extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.pushToMovieDetailViewController(with: currentMovieSearchResult[indexPath.row])
    }
}
