//
//  CovidDetailViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/04.
//

import UIKit
import SnapKit
import Then

class CovidDetailViewController: UITableViewController {

    let titleArr: [String] = [
        "신규 확진자",
        "확진자",
        "완치자",
        "사망자",
        "발생률",
        "해외유입 신규 확진자",
        "지역발생 신규 확진자"
    ]
    
    let numArr: [String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CovidDetailTableCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CovidDetailTableCell else { return UITableViewCell() }
        
        cell.titleLbl.text = titleArr[indexPath.row]
        cell.numLbl.text = numArr[indexPath.row]

        return cell
    }
    


}
