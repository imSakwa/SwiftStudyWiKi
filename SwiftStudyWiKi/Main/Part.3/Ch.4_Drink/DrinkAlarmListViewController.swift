//
//  DrinkAlarmListViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/08.
//

import UIKit

class DrinkAlarmListViewController: UITableViewController {

    var alertList: [Alert] = []
    
    let addBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.addTarget(self, action: #selector(tapAddBtn), for: .touchUpInside)
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "물마시기"
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
        self.tableView.register(DrinkAlarmTableViewCell.self, forCellReuseIdentifier: "listCell")
    }
    
    @objc private func tapAddBtn(_ sender: UIButton) {
        if #available(iOS 13.4, *) {
            let addVC = DrinkAddAlarmViewController()
            addVC.pickedDate = { [weak self] date in
                guard let self = self else { return }
                
                let newAlert = Alert(date: date, isOn: true)
            }
            
            self.present(addVC, animated: true)
        } else {
            print("버전 낮음..")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? DrinkAlarmTableViewCell else { return UITableViewCell() }
        
        cell.onoffSwitch.isOn = alertList[indexPath.row].isOn
        cell.timeLbl.text = alertList[indexPath.row].time
        cell.amLbl.text = alertList[indexPath.row].meridiem
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            return
        default:
            break
        }
    }
}
