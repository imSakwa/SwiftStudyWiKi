//
//  DiaryTabBarController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/25.
//

import UIKit
import SnapKit
import Then

class DiaryTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let diaryVC1 = DiaryViewController()
        diaryVC1.title = "일기장"
        diaryVC1.tabBarItem.image = UIImage(systemName: "folder.fill")
        
        let diaryVC2 = DiaryFavoItemViewController()
        diaryVC2.title = "즐겨찾기"
        diaryVC2.tabBarItem.image = UIImage(systemName: "star")
        
        let nav1 = UINavigationController(rootViewController: diaryVC1)
        let nav2 = UINavigationController(rootViewController: diaryVC2)
        
        
        setViewControllers([nav1,nav2], animated: true)
    }
    



}
