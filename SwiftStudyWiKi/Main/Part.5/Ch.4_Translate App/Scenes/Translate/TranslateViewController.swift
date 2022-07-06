//
//  TranslateViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import UIKit
import SnapKit
import Then

final class TranslateViewController: UIViewController {
    private var translateManager = TranslatorManager()
        
    private lazy var sourceLanguageBtn = UIButton().then {
        $0.setTitle(translateManager.sourceLanguage.title, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.setTitleColor(.label, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 9
        $0.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
    }
    
    private lazy var targetLanguageBtn = UIButton().then {
        $0.setTitle(translateManager.targetLanguage.title, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.setTitleColor(.label, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 9
        $0.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
    }
    
    private lazy var buttonStackView = UIStackView().then { view in
        view.distribution = .fillEqually
        view.axis = .horizontal
        view.spacing = 8
        
        [sourceLanguageBtn, targetLanguageBtn]
            .forEach { view.addArrangedSubview($0) }
    }
    
    private lazy var resultBaseView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var resultLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 23, weight: .bold)
        $0.textColor = .mainTintColor
        $0.numberOfLines = 0
    }
    
    private lazy var bookmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
    }
    
    private lazy var copyButton = UIButton().then {
        $0.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        $0.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
    }
    
    private lazy var sourceLabelBaseButton = UIView().then {
        $0.backgroundColor = .systemBackground
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapSourceLabelBaseButton))
        $0.addGestureRecognizer(gesture)
    }
    
    private lazy var sourceLabel = UILabel().then {
        $0.text = NSLocalizedString("Enter_text", comment: "텍스트 입력")
        $0.textColor = .tertiaryLabel
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 23, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        
        setupViews()
    }
    
    @objc func didtapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true)
    }

}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText == "" { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        translateManager.translate(from: sourceText) { [weak self] translatedText in
            self?.resultLbl.text = translatedText
        }
    }
}

private extension TranslateViewController {
    func setupViews() {
        [
            buttonStackView,
            resultBaseView,
            resultLbl,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel
        ]
            .forEach { view.addSubview($0)}
        
        let defaultSpacing: CGFloat = 16
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultLbl.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(resultBaseView).inset(24)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLbl)
            $0.top.equalTo(resultLbl.snp.bottom).offset(24)
            $0.size.equalTo(40)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).offset(8)
            $0.top.equalTo(resultLbl.snp.bottom).offset(24)
            $0.size.equalTo(40)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(sourceLabelBaseButton).inset(24)
        }
    }
    
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(type: .source)
    }
    
    @objc func didTapTargetLanguageButton() {
        didTapLanguageButton(type: .target)
    }
    
    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { [weak self] _ in
                switch type {
                case .source:
                    self?.translateManager.sourceLanguage = language
                    self?.sourceLanguageBtn.setTitle(language.title, for: .normal)
                case .target:
                    self?.translateManager.targetLanguage = language
                    self?.targetLanguageBtn.setTitle(language.title, for: .normal)
                }
                
            }
            
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "취소"), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc func didTapBookmarkButton() {
        guard
            let sourceText = sourceLabel.text,
            let translatedText = resultLbl.text,
            bookmarkButton.imageView?.image == UIImage(systemName: "bookmark")
        else { return }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(
            sourceLanguage: translateManager.sourceLanguage,
            translatedLanguage: translateManager.targetLanguage,
            sourceText: sourceText,
            translatedText: translatedText
        )
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
    }
    
    @objc func didTapCopyButton() {
        UIPasteboard.general.string = resultLbl.text
    }
}
