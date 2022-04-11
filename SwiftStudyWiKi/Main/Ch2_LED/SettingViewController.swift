//
//  SettingViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/10.
//

import UIKit

protocol SettingDelegate: AnyObject {
    func changeSetting(text: String?, color: UIColor , backColor: UIColor)
}

class SettingViewController: UIViewController {

    var colorValue: Int = 0 // 0:빨강, 1:파랑, 2: 초록
    var backColorValue: Int = 0 // 0:빨강, 1:파랑, 2: 초록
    
    weak var delegate: SettingDelegate?
    var color: UIColor = .black
    var backColor: UIColor = .red
    
    let naviView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let backBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
    }
    
    let ledLblOptionStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let ledLblOptionTitle = UILabel().then {
        $0.text = "표시할 글씨 입력"
    }
    
    let ledLblTextField = UITextField().then {
        $0.placeholder = "표시할 글씨를 입력해주세요."
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 6
        $0.layer.borderWidth = 1
        $0.leftViewMode = .always
    }
    
    let ledColorOptionStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let ledColorOptionTitle = UILabel().then {
        $0.text = "LED 글씨 색상 선택"
    }
    
    let ledColorStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    let ledRedColorBtn = UIButton(type: .system).then {
        $0.setTitle("빨간색", for: .normal)
        $0.tag = 0
        $0.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
    let ledBlueColorBtn = UIButton(type: .system).then {
        $0.setTitle("파란색", for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
    let ledGreenColorBtn = UIButton(type: .system).then {
        $0.setTitle("초록색", for: .normal)
        $0.tag = 2
        $0.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
    }
    
    let ledBackColorOptionStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    let ledBackColorOptionTitle = UILabel().then {
        $0.text = "LED 배경 색상 선택"
    }
    
    let ledBackColorStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    let ledBackRedColorBtn = UIButton(type: .system).then {
        $0.setTitle("빨간색", for: .normal)
        $0.tag = 0
        $0.addTarget(self, action: #selector(changeBackColor), for: .touchUpInside)
    }
    
    let ledBackBlueColorBtn = UIButton(type: .system).then {
        $0.setTitle("파란색", for: .normal)
        $0.tag = 1
        $0.addTarget(self, action: #selector(changeBackColor), for: .touchUpInside)
    }
    
    let ledBackGreenColorBtn = UIButton(type: .system).then {
        $0.setTitle("초록색", for: .normal)
        $0.tag = 2
        $0.addTarget(self, action: #selector(changeBackColor), for: .touchUpInside)
    }
    
    let saveBtn = UIButton(type: .system).then {
        $0.setTitle("저장하기", for: .normal)
        $0.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        addView()
    }
    
    @objc private func changeColor(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            color = .red
        case 1:
            color = .blue
        case 2:
            color = .green
        default:
            break
        }
    }
    
    @objc private func changeBackColor(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            backColor = .red
        case 1:
            backColor = .blue
        case 2:
            backColor = .green
        default:
            break
        }
    }
    
    @objc private func clickSaveBtn(_ sender: UIButton) {
        delegate?.changeSetting(text: self.ledLblTextField.text, color: self.color, backColor: self.backColor)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func addView() {
        view.addSubview(naviView)
        naviView.addSubview(backBtn)
        
        view.addSubview(ledLblOptionStack)
        ledLblOptionStack.addArrangedSubview(ledLblOptionTitle)
        ledLblOptionStack.addArrangedSubview(ledLblTextField)
        
        ledLblTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        view.addSubview(ledColorOptionStack)
        ledColorOptionStack.addArrangedSubview(ledColorOptionTitle)
        ledColorOptionStack.addArrangedSubview(ledColorStack)
        ledColorStack.addArrangedSubview(ledRedColorBtn)
        ledColorStack.addArrangedSubview(ledBlueColorBtn)
        ledColorStack.addArrangedSubview(ledGreenColorBtn)
        
        view.addSubview(ledBackColorOptionStack)
        ledBackColorOptionStack.addArrangedSubview(ledBackColorOptionTitle)
        ledBackColorOptionStack.addArrangedSubview(ledBackColorStack)
        ledBackColorStack.addArrangedSubview(ledBackRedColorBtn)
        ledBackColorStack.addArrangedSubview(ledBackBlueColorBtn)
        ledBackColorStack.addArrangedSubview(ledBackGreenColorBtn)
        
        view.addSubview(saveBtn)
        
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
        
        ledLblOptionStack.snp.makeConstraints {
            $0.top.equalTo(naviView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        ledLblOptionTitle.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        ledLblTextField.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        ledColorOptionStack.snp.makeConstraints {
            $0.top.equalTo(ledLblOptionStack.snp.bottom).offset(30)
            $0.leading.equalTo(ledLblOptionStack.snp.leading)
        }
        
        ledColorOptionTitle.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        ledBackColorOptionStack.snp.makeConstraints {
            $0.top.equalTo(ledColorOptionStack.snp.bottom).offset(30)
            $0.leading.equalTo(ledLblOptionStack.snp.leading)
        }
        
        ledBackColorOptionTitle.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        saveBtn.snp.makeConstraints {
            $0.top.equalTo(ledBackColorOptionStack.snp.bottom).offset(45)
            $0.centerX.equalToSuperview()
        }
        
    }


    @objc private func clickBackBtn() {
        self.navigationController?.popViewController(animated: true)
    }
}
