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

    private let titleLbl = UILabel().then {
        $0.text = "명언 생성기"
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    private let quotesView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private let quotesLbl = UILabel().then {
        $0.text = "명언"
        $0.numberOfLines = 0
    }
    
    private let quotesPersonNM = UILabel().then {
        $0.text = "이름"
    }
    
    private let generateBtn = UIButton(type: .system).then {
        $0.setTitle("명언 생성", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupViewLayout()
    }
    
    private func setupViewLayout() {
        self.view.addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.view.addSubview(quotesView)
        quotesView.snp.makeConstraints {
            $0.top.equalTo(titleLbl.snp.bottom).offset(80)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(200)
        }
        
        quotesView.addSubview(quotesLbl)
        quotesLbl.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        quotesView.addSubview(quotesPersonNM)
        quotesPersonNM.snp.makeConstraints {
            $0.top.equalTo(quotesLbl.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview().inset(20)
        }
        
        quotesLbl.setContentHuggingPriority(.defaultLow, for: .vertical)
        quotesPersonNM.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        quotesLbl.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        quotesPersonNM.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        self.view.addSubview(generateBtn)
        generateBtn.snp.makeConstraints {
            $0.top.equalTo(quotesView.snp.bottom).offset(20)
            $0.centerX.equalTo(quotesView)
        }
    }
}
