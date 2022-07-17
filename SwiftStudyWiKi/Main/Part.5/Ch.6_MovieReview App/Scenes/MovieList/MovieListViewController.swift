//
//  MovieReviewViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/15.
//

import UIKit
import SnapKit
import Then

final class MovieListViewController: UIViewController {
    private lazy var presenter = MovieListPresenter(viewController: self)
    
    private let searchController = UISearchController()
        
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let collectionViewLayout = UICollectionViewFlowLayout()
        $0.collectionViewLayout = collectionViewLayout
        $0.backgroundColor = .systemBackground
        $0.delegate = presenter
        $0.dataSource = presenter
        $0.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
    }
    
    private lazy var searchResultTableView = UITableView().then {
        $0.delegate = presenter
        $0.dataSource = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension MovieListViewController: MovieListProtocol {
    
    func setNavigationBar() {
        view.backgroundColor = .white
        
        navigationItem.title = "영화 평점"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
    }
    
    func setupViews() {
        [collectionView, searchResultTableView]
            .forEach { view.addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchResultTableView.isHidden = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        searchResultTableView.isHidden = isHidden
        searchResultTableView.reloadData()
    }
    
    func pushToMovieDetailViewController(with movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
