//
//  SpotifyEnterEmailViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/06.
//

import UIKit
import SnapKit
import Then
import FirebaseAuth

class SpotifyEnterEmailViewController: UIViewController {

    let stack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 20
    }
    
    let emailLbl = UILabel().then {
        $0.text = "이메일 주소가 무엇인가요?"
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let emailTextField = UITextField().then {
        $0.backgroundColor = .white
    }
    
    let pwLbl = UILabel().then {
        $0.text = "비밀번호를 입력해주세요."
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    let pwTextField = UITextField().then {
        $0.isSecureTextEntry = true
        $0.backgroundColor = .white
    }
    
    let errorLbl = UILabel().then {
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    let nextBtn = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 30
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = false
        self.title = "이메일/비밀번호 입력하기"
        
        emailTextField.delegate = self
        pwTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        
        setupView()
    }
    
    @objc private func tapNextBtn(_ sender: UIButton) {
        let email = emailTextField.text ?? ""
        let pw = pwTextField.text ?? ""
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: pw) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                
                switch code {
                case 17007: //이미 가입한 계정
                    self.loginUser(withEmail: email, pw: pw)
                default:
                    self.errorLbl.text = error.localizedDescription
                }
            } else {
                self.showMainVC()
            }
        }
    }
    
    private func loginUser(withEmail email: String, pw: String) {
        Auth.auth().signIn(withEmail: email, password: pw) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorLbl.text = error.localizedDescription
            } else {
                self.showMainVC()
            }
        }
    }
    
    private func showMainVC() {
        let mainVC = SpotifyMainViewController()
        mainVC.loginType = .email
        self.navigationController?.pushViewController(SpotifyMainViewController(), animated: true)
    }
    
    private func setupView() {
        view.addSubview(stack)
        stack.addArrangedSubview(emailLbl)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(pwLbl)
        stack.addArrangedSubview(pwTextField)
        
        view.addSubview(errorLbl)
        view.addSubview(nextBtn)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(70)
        }
        
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        pwTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        errorLbl.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(5)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(60)
        }
    }
}

extension SpotifyEnterEmailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPWEmpty = pwTextField.text == ""
        
        nextBtn.isEnabled = !isEmailEmpty && !isPWEmpty
    }
}
