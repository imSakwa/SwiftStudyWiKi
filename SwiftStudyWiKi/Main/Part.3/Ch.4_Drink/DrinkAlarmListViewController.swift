//
//  DrinkAlarmListViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/08.
//

import UIKit
import Then
import SnapKit

class DrinkAlarmListViewController: UITableViewController {

    var alerts: [Alert] = []
    
    let addBtn = UIButton(type: .custom).then {
        $0.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "물마시기"
        
        addBtn.addTarget(self, action: #selector(tapAddBtn), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
        self.tableView.register(DrinkAlarmTableViewCell.self, forCellReuseIdentifier: "listCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        alerts = alertList()
    }
    
    @objc func tapAddBtn() {
        let addVC = DrinkAddAlarmViewController()
        
        addVC.pickedDate = { [weak self] date in
            guard let self = self else { return }

            var alertList = self.alertList()
            let newAlert = Alert(date: date, isOn: true)

            alertList.append(newAlert)

            alertList.sort { $0.date < $1.date } // 시간 순서대로 정렬

            self.alerts = alertList
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")

            self.tableView.reloadData()
        }
        
        present(addVC, animated: true, completion: nil)
    }
    
    private func alertList() -> [Alert] {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
        return alerts
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? DrinkAlarmTableViewCell else { return UITableViewCell() }
        
        cell.onoffSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLbl.text = alerts[indexPath.row].time
        cell.amLbl.text = alerts[indexPath.row].meridiem
        cell.onoffSwitch.tag = indexPath.row
        
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
            self.alerts.remove(at: indexPath.row)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.alerts), forKey: "alerts")
            
            self.tableView.reloadData()
            
            return
        default:
            break
        }
    }
}
