//
//  ReviewListPresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/07.
//

import UIKit

protocol ReviewListProtocol {
    func setupNavigationBar()
    func setupViews()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}
