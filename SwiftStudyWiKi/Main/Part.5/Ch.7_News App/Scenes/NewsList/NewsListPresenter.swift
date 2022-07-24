//
//  NewsListPresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/17.
//

import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func moveToNewsWebViewController(with news: News)
    func reloadTableView()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    
    private var newsList: [News] = []
    private var currentKeyword: String = "아이폰"
    // 현재의 페이지
    private var currentPage: Int = 0
    // 몇 개를 보여줄 것 인지
    private let display: Int = 20
    
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
        
        requestNewsList()
    }
    
    func didCalledRefresh() {
        requestNewsList(isNeededToReset: true)
    }
}

extension NewsListPresenter: UITableViewDelegate {
    
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.identifier,
            for: indexPath
        ) as? NewsListTableViewCell
        
        cell?.setup(news: newsList[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListTableHeaderView.identifier) as? NewsListTableHeaderView
        
        header?.setup()
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewController?.moveToNewsWebViewController(with: newsList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        
        guard (currentRow % 20 == display - 3) && (currentRow / display == currentPage - 1)else { return }
        
        requestNewsList()
    }
}

private extension NewsListPresenter {
    func requestNewsList(isNeededToReset: Bool = false) {
        if isNeededToReset {
            currentPage = 0
            newsList = []
        }
        newsSearchManager.request(
            from: currentKeyword,
            start: (currentPage * display) + 1,
            display: display
        ) { [weak self] newValue in
            self?.newsList += newValue
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
        }
    }
}
