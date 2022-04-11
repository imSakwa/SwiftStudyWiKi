//
//  LEDViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/10.
//

import UIKit
import SnapKit
import Then

class LEDViewController: UIViewController, SettingDelegate {
    func changeSetting(text: String?, color: UIColor, backColor: UIColor) {
        ledLbl.text = text
        ledLbl.textColor = color
        ledLbl.backgroundColor = backColor
    }
    

    let naviView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let backBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
    }
    
    let settingBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "gear"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
    }
    
    let ledLbl = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 26, weight: .bold)
        $0.text = "임시 라벨"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addView()
        
    }

    private func addView() {
        view.addSubview(naviView)
        naviView.addSubview(backBtn)
        naviView.addSubview(settingBtn)
        view.addSubview(ledLbl)
        
        addConstraint()
    }
    
    private func addConstraint() {
        naviView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        settingBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        
        ledLbl.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
//            $0.top.equalTo(naviView.snp.bottom).offset(30)
        }
    }
    
    @objc private func clickSetting() {
        let settingVC = SettingViewController()
        settingVC.delegate = self
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc private func clickBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
