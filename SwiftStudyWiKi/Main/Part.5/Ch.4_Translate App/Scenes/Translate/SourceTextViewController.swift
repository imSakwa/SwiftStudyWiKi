//
//  SourceTextViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import SnapKit
import UIKit
import Then

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextViewController: UIViewController {
    private let placeholderText = NSLocalizedString("Enter_text", comment: "텍스트 입력")
    
    private weak var delgate: SourceTextViewControllerDelegate?
    
    private lazy var textView = UITextView().then {
        $0.text = placeholderText
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.returnKeyType = .done
        $0.delegate = self
    }
    
    init(delegate: SourceTextViewControllerDelegate) {
        self.delgate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

extension SourceTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        
        delgate?.didEnterText(textView.text)
        
        dismiss(animated: true)
        return true
        
    }
}
