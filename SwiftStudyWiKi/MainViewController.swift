//
//  ViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/26.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        self.navigationItem.title = "hi"
        
        if let navi = self.navigationController as? MyNavigationController {
            navi.setNaviBarColor()
        }
        // Do any additional setup after loading the view.
    }


}

