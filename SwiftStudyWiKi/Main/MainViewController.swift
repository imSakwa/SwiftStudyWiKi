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
        [
            "1. Prefetch",
            "2. 명언 생성기",
            "3. LED",
            "4. ????",
            "5. Diary",
            "6. ?????",
            "7. Weather",
            "8. Covid"
        ],
        [
            "0. Alamofire 연습",
            "1. Spotify",
            "2. Drink",
        ],
        [
            "1. Translate App",
            "2. BookReview App",
            "3. MovieReview App"
        ]
    ]
    
    let naviBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let naviTestButton = UIButton(type: .custom).then {
        $0.addTarget(self, action: #selector(clickNaviTestBtn), for: .touchUpInside)
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        $0.tintColor = .red
    }
    
    let naviTitleLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
        $0.text = "Chagmn's Swift WiKi"
    }
    
    
    let subjectTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationController?.isNavigationBarHidden = true
        
        setLayout()
        setSubjectTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func clickNaviTestBtn(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    private func setSubjectTableView() {
        subjectTableView.dataSource = self
        subjectTableView.delegate = self
        subjectTableView.register(SubjectTableCell.self, forCellReuseIdentifier: "SubjectCell")
    }
    
    private func setLayout() {
        self.view.addSubview(naviBarView)
        naviBarView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        naviBarView.addSubview(naviTestButton)
        naviTestButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        naviBarView.addSubview(naviTitleLbl)
        naviTitleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        self.view.addSubview(subjectTableView)
        subjectTableView.snp.makeConstraints {
            $0.top.equalTo(naviBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArr[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as? SubjectTableCell else {
            return UITableViewCell()
        }
        
        cell.titleLbl.text = cellTitleArr[indexPath.section][indexPath.row]
        cell.nextIcon.tintColor = .black
        cell.selectionStyle = .none
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(PrefetchViewController(), animated: true)
                
            case 1:
                self.navigationController?.pushViewController(QuotesGeneratorViewController(), animated: true)
                
            case 2:
                self.navigationController?.pushViewController(LEDViewController(), animated: true)
                
            case 4:
                self.navigationController?.pushViewController(DiaryTabBarController(), animated: true)
                
            case 6:
                self.navigationController?.pushViewController(WeatherViewController(), animated: true)
                
            case 7:
                self.navigationController?.pushViewController(CovidViewController(), animated: true)
                
            default:
                break
            }
            
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                //AlamofireViewController
                self.navigationController?.pushViewController(TestVC(), animated: true)
                
            case 1:
                self.navigationController?.pushViewController(SpotifyLoginViewController(), animated: true)
                
            case 2:
                self.navigationController?.pushViewController(DrinkAlarmListViewController(style: .grouped), animated: true)
            
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let tabBarVC = TabBarController()
                tabBarVC.view.tintColor = .mainTintColor
                self.navigationController?.pushViewController(tabBarVC, animated: true)
                
            case 1:
                let reviewVC = ReviewListViewController()
                
                let naviVC = UINavigationController(rootViewController: reviewVC)
                naviVC.modalPresentationStyle = .fullScreen
                
                self.present(naviVC, animated: true)
                
            case 2:
                let movieReviewVC = MovieReviewViewController()
                
                let naviVC = UINavigationController(rootViewController: movieReviewVC)
                naviVC.modalPresentationStyle = .fullScreen
                
                self.present(naviVC, animated: true)
            
            default:
                break
            }
        }
       
    }
}
