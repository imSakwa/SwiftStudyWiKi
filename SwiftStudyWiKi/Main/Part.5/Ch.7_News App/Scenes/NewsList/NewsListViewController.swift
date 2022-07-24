//
//  NewsViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class NewsListViewController: UIViewController {
    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var refreshControl = UIRefreshControl().then {
        $0.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
    }
    
    private lazy var tableView = UITableView().then {
        $0.delegate = presenter
        $0.dataSource = presenter
        $0.register(NewsListTableViewCell.self, forCellReuseIdentifier: NewsListTableViewCell.identifier)
        $0.refreshControl = refreshControl
        $0.register(NewsListTableHeaderView.self, forHeaderFooterViewReuseIdentifier: NewsListTableHeaderView.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func moveToNewsWebViewController(with news: News) {
        let newsWebVC = NewsWebViewController(news: news)
        
        navigationController?.pushViewController(newsWebVC, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}
