//
//  SpotifyMainViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/06.
//

import UIKit
import SnapKit
import Then

class SpotifyMainViewController: UIViewController {

    let firstlbl = UILabel().then {
        $0.text = "환양합니다."
        $0.font = .boldSystemFont(ofSize: 25)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    let logoutBtn = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.systemGray5, for: .normal)
        $0.addTarget(self, action: #selector(tapLogoutBtn), for: .touchUpInside)
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func tapLogoutBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.addSubview(firstlbl)
        view.addSubview(logoutBtn)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        firstlbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        logoutBtn.snp.makeConstraints {
            $0.top.equalTo(firstlbl.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    


}
