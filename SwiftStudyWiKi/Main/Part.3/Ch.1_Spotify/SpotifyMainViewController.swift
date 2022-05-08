//
//  SpotifyMainViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/06.
//

import UIKit
import SnapKit
import Then
import FirebaseAuth
import GoogleSignIn

enum LoginType {
    case email
    case google
    case apple
}
class SpotifyMainViewController: UIViewController {

    var loginType: LoginType = .email
    
    let welcomelbl = UILabel().then {
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
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomelbl.text = """
         환영합니다.
         \(email)님
         """
    }
    
    @objc private func tapLogoutBtn() {
        switch loginType {
        case .email:
            let firebaseAuth = Auth.auth()
            
            do {
                try firebaseAuth.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch let sighOutError as NSError {
                print("Error : \(sighOutError.localizedDescription)")
            }
            
        case .google:
            GIDSignIn.sharedInstance.signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        case .apple:
            break
            
        default:
            break
        }
      
    }
    
    private func setupView() {
        view.addSubview(welcomelbl)
        view.addSubview(logoutBtn)
        
        setupConstraint()
    }
    
    private func setupConstraint() {
        welcomelbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        logoutBtn.snp.makeConstraints {
            $0.top.equalTo(welcomelbl.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    


}
