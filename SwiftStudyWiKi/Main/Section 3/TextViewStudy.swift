//
//  TextViewStudy.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/12/29.
//

import UIKit

import SnapKit

final class TextViewStudy: UIViewController {
    
    private lazy var styleOffTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .systemGray4
        textView.text =
"""
감사합니다 감사합니다. 감사합니다. 감사합니다. 감사합니다. 감사합니다. 감사합니다. \n
안녕하세요. 2022년도 이제 다 지나고 2023년이 찾아오고 있네요. 모두 새해에는 원하시는 것들 모두 다 이루시고 좋은 일만 가득하시길 바랍니다.
"""
        textView.isEditable = false
        return textView
    }()
    
    private lazy var styleOnTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .systemGray6
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        setupTextView()
    }
}

extension TextViewStudy {
    private func setupTextView() {
        let paragraph: NSMutableParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.lineBreakStrategy = .hangulWordPriority
            return style
        }()
        
        let tempStr =
        """
        감사합니다 감사합니다. 감사합니다. 감사합니다. 감사합니다. 감사합니다. 감사합니다.\n
        안녕하세요. 2022년도 이제 다 지나고 2023년이 찾아오고 있네요. 모두 새해에는 원하시는 것들 모두 다 이루시고 좋은 일만 가득하시길 바랍니다.
        """
        
        let attributeStr = NSMutableAttributedString(
            string: tempStr,
            attributes: [
                .paragraphStyle : paragraph
            ]
        )
        
        styleOnTextView.attributedText = attributeStr
    }
    
    private func setupLayout() {
        [styleOffTextView, styleOnTextView].forEach { view.addSubview($0) }
        
        styleOffTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
        
        styleOnTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(styleOffTextView.snp.bottom).offset(12)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(300)
        }
    }
}
