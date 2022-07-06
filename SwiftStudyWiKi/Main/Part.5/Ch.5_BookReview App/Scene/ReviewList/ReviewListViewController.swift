//
//  ReviewListViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/07.
//

import UIKit
import SnapKit
import Then

final class ReviewListViewController: UIViewController {
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView = UITableView().then {
        $0.dataSource = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension ReviewListViewController: ReviewListProtocol {
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
