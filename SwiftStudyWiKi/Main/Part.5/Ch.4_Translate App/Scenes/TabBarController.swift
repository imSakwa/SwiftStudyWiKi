//
//  TabBarController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        
        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(
            title: "번역",
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookmarkViewController = UIViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: "즐겨찾기",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        viewControllers = [translateViewController, bookmarkViewController]
    }
}
