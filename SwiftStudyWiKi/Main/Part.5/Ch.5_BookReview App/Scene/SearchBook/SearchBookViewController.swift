//
//  SearchBookViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/10.
//

import SnapKit
import UIKit

final class SearchBookViewController: UIViewController {
    private lazy var presenter = SearchBookPresenter(viewController: self, delegate: searchBookDelegate)
    
    private let searchBookDelegate: SearchBookDelegate
    
    private lazy var tableView = UITableView().then {
        $0.delegate = presenter
        $0.dataSource = presenter
    }
    
    init(searchBookDelegate: SearchBookDelegate) {
        self.searchBookDelegate = searchBookDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension SearchBookViewController: SearchBookProtocol {
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}
