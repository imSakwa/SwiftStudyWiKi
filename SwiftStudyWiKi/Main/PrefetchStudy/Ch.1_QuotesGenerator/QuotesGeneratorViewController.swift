//
//  QuotesGeneratorViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/05.
//

import UIKit
import SnapKit
import Then

class QuotesGeneratorViewController: UIViewController {

    private let titleLbl = UILabel()
    
    private let quotesView = UIView()
    
    private let quotesLbl = UILabel()
    
    private let changeBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewLayout()
    }
    
    private func setupViewLayout() {
        self.view.addSubview(titleLbl)
    }
}
