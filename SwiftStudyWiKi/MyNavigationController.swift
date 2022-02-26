//
//  MyNavigationController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/26.
//

import UIKit

class MyNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    func setNaviBarColor() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.backgroundColor = .green
        appearance.shadowColor = .clear
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.brown]
          
        self.navigationController?.navigationBar.tintColor = .yellow
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
}
