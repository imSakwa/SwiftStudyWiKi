//
//  ViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {

    let cellTitleArr = [
        "1. Prefetch",
        "2. ",
        "3. "
    ]
    
    let subjectTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Chagmn's Swift WiKi📕"
        
        setLayout()
        setSubjectTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setSubjectTableView() {
        subjectTableView.dataSource = self
        subjectTableView.delegate = self
        subjectTableView.register(SubjectTableCell.self, forCellReuseIdentifier: "SubjectCell")
    }
    
    private func setLayout() {
        self.view.addSubview(subjectTableView)
        subjectTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as? SubjectTableCell else {
            return UITableViewCell()
        }
        
        cell.titleLbl.text = cellTitleArr[indexPath.row]
        cell.nextIcon.tintColor = .black
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem

        switch indexPath.row {
        case 0:
            let vc = PrefetchViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
