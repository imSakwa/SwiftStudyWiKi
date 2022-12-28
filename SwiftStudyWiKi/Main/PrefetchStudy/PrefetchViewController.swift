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
    
    let arr = Array(1...100).map { "\($0)" }
    
//    let viewModel = Array(1...100).map { _ in ViewModel() }
//    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Prefetch TableView"
         
        setTableView()
    }
    
    private func setTableView() {
        prefetchTableView.delegate = self
        prefetchTableView.dataSource = self
        prefetchTableView.prefetchDataSource = self
//        prefetchTableView.rowHeight = 300
//        prefetchTableView.estimatedRowHeight = UITableView.automaticDimension
        
        prefetchTableView.register(PrefetchTableCellTableViewCell.self, forCellReuseIdentifier: "prefetchCell")
        
        self.view.addSubview(prefetchTableView)
        prefetchTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    

}

extension PrefetchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "prefetchCell", for: indexPath) as? PrefetchTableCellTableViewCell else { return UITableViewCell() }
        
        print("cellForRow : \(indexPath.row+1)")
        cell.textlbl.text = arr[indexPath.row]
//        cell.configure(viewModel: viewModel[indexPath.row], index: indexPath)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
////        let cell = tableView.dequeueReusableCell(withIdentifier: "prefetchCell", for: indexPath) as! PrefetchTableCellTableViewCell
////
////        cell.configure(viewModel: viewModel, index: indexPath)
//        print("willDisplay : \(indexPath.row)")
//    }
}

extension PrefetchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        for indexPath in indexPaths {
            print("prefectRowAt : \(indexPath.row)")
            
//            let viewModel = viewModel[indexPath.row]
//            viewModel.downloadImage(row: indexPath.row, completion: nil)
        }
    }
}
