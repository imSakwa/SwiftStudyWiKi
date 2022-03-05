//
//  PrefetchViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/03/01.
//

import UIKit
import SnapKit
import Then

class PrefetchViewController: UIViewController {
    
    let prefetchTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Prefetch"
        
        setTableView()
    }
    
    private func setTableView() {
        prefetchTableView.delegate = self
        prefetchTableView.dataSource = self
    }
}

extension PrefetchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
