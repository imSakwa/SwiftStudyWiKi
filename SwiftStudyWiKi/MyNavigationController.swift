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
        

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.backgroundColor = .green
        appearance.shadowColor = .clear
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.brown]
          
        self.navigationController?.navigationBar.tintColor = .yellow
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationBar.setNeedsLayout()
        
        self.navigationBar.frame.size = self.navigationBar.sizeThatFits(CGSize(width: self.navigationBar.frame.size.width, height: 50))
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

extension UINavigationBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var barHeight: CGFloat = 50
    
        if size.height == 50 {
            barHeight = size.height
        }
    
        let newSize: CGSize = CGSize(width: self.frame.size.width, height: barHeight)
        return newSize
    }
}
