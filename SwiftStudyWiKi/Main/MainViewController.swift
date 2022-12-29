//
//  ViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/26.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    private let cellTitleArr = [
        [
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
            "3. MovieReview App",
            "4. News App"
        ],
        [
            "1. textView 연습"
        ]
    ]
    
    private lazy var naviBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var naviTestButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(clickNaviTestBtn), for: .touchUpInside)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .red
        return button
    }()
    
    private lazy var naviTitleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "Chagmn's Swift WiKi"
        return label
    }()
    
    private lazy var subjectTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubjectTableCell.self, forCellReuseIdentifier: "SubjectCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setLayout()
    }
        
    @objc func clickNaviTestBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    private func setLayout() {
        [naviBarView, subjectTableView].forEach { view.addSubview($0) }
        [naviTestButton, naviTitleLbl].forEach { naviBarView.addSubview($0) }
        
        naviBarView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        naviTestButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        naviTitleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
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
        cell.setupData(data: cellTitleArr[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//        backBarButtonItem.tintColor = .black
//        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationItem.leftItemsSupplementBackButton = true

        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(QuotesGeneratorViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(LEDViewController(), animated: true)
            case 3:
                navigationController?.pushViewController(DiaryTabBarController(), animated: true)
            case 5:
                navigationController?.pushViewController(WeatherViewController(), animated: true)
            case 6:
                navigationController?.pushViewController(CovidViewController(), animated: true)
            default:
                break
            }
            
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                //AlamofireViewController
                navigationController?.pushViewController(TestVC(), animated: true)
            case 1:
                navigationController?.pushViewController(SpotifyLoginViewController(), animated: true)
            case 2:
                navigationController?.pushViewController(DrinkAlarmListViewController(style: .grouped), animated: true)
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                let tabBarVC = TabBarController()
                tabBarVC.view.tintColor = .mainTintColor
                navigationController?.pushViewController(tabBarVC, animated: true)
                
            case 1:
                let reviewVC = ReviewListViewController()
                let naviVC = UINavigationController(rootViewController: reviewVC)
                naviVC.modalPresentationStyle = .fullScreen
                
                present(naviVC, animated: true)
                
            case 2:
                let movieReviewVC = MovieListViewController()
                let naviVC = UINavigationController(rootViewController: movieReviewVC)
                naviVC.modalPresentationStyle = .fullScreen
                
                present(naviVC, animated: true)
                
            case 3:
                let newsVC = NewsListViewController()
                let naviVC = UINavigationController(rootViewController: newsVC)
                naviVC.modalPresentationStyle = .fullScreen
                
                present(naviVC, animated: true)
            
            default:
                break
            }
        } else if indexPath.section == 3 {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(TextViewStudy(), animated: true)
            default:
                break
            }
        }
    }
}
