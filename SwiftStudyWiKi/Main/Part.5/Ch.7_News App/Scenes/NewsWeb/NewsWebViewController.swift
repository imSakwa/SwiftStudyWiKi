//
//  NewsWebViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/24.
//

import WebKit
import SnapKit
import UIKit

final class NewsWebViewController: UIViewController {
    private let news: News
    private let webView = WKWebView()
    
    private lazy var rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    init(news: News) {
        self.news = news
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = news.title
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: news.link) else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view = webView
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = news.link
    }
}
