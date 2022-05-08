//
//  SpotifyLoginViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/06.
//

import UIKit
import SnapKit
import Then
import GoogleSignIn
import Firebase

class SpotifyLoginViewController: UIViewController {
    
    let loginStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    let loginImg = UIImageView().then {
        $0.tintColor = .white
        $0.image = UIImage(systemName: "music.note.house.fill")
    }
    
    let loginLbl = UILabel().then {
        $0.text = "내 마음에 꼭 드는 또 다른\n플레이리스트를\n발견해보세요."
        $0.font = .boldSystemFont(ofSize: 31)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 3
        $0.sizeToFit()
    }
    
    let btnStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    let emailLoginBtn = UIButton().then {
        $0.setTitle("이메일/비밀번호로 계속하기", for: .normal)
        $0.tag = 0
    }
    
    let googleLoginBtn = UIButton().then {
        $0.setTitle("구글로 계속하기", for: .normal)
        $0.setImage(UIImage(named: "logo_google"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -119, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -31, bottom: 0, right: 0)
        $0.tag = 1
    }
    
    let appleLoginBtn = UIButton().then {
        $0.setTitle("Apple로 계속하기", for: .normal)
        $0.setImage(UIImage(named: "logo_apple"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -119, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -31, bottom: 0, right: 0)
        $0.tag = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        [emailLoginBtn, googleLoginBtn, appleLoginBtn].forEach {
            $0.layer.cornerRadius = 30
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
            $0.addTarget(self, action: #selector(tapLoginBtn), for: .touchUpInside)
        }
        
        setupView()
    }
    
    @objc private func tapLoginBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            self.navigationController?.pushViewController(SpotifyEnterEmailViewController(), animated: true)
            
        } else if sender.tag == 1 {
            let signInConfig = GIDConfiguration.init(clientID: (FirebaseApp.app()?.options.clientID ?? ""))
            
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                
                let mainVC = SpotifyMainViewController()
                mainVC.loginType = .google
                self.navigationController?.pushViewController(mainVC, animated: true)
            }
        } else {
            
        }
    }

    private func setupView() {
        view.addSubview(loginStack)
        loginStack.addArrangedSubview(loginImg)
        loginStack.addArrangedSubview(loginLbl)
        
        view.addSubview(btnStack)
        btnStack.addArrangedSubview(emailLoginBtn)
        btnStack.addArrangedSubview(googleLoginBtn)
        btnStack.addArrangedSubview(appleLoginBtn)
        
 
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        loginStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        loginImg.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(80)
        }
        
        btnStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginStack.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        emailLoginBtn.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
        }
        
        googleLoginBtn.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
        }
        
        appleLoginBtn.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
        }
    }
}
