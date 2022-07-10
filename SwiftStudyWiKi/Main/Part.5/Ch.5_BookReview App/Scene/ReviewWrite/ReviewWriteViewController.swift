//
//  ReviewWriteViewController.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/09.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton = UIButton().then {
        $0.setTitle("책 제목", for: .normal)
        $0.setTitleColor(.tertiaryLabel, for: .normal)
        $0.contentHorizontalAlignment = .leading
        $0.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        $0.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
    }
    
    private lazy var contentsTextView = UITextView().then {
        $0.textColor = .tertiaryLabel
        $0.text = "내용을 입력해주세요."
        $0.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.delegate = self
    }
    
    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .secondarySystemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: nil
        )
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(
            title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?",
            message: nil,
            preferredStyle: .alert
        )
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [closeAction, cancelAction].forEach { alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentsTextView, imageView]
            .forEach { view.addSubview($0) }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentsTextView)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentToSearchBookViewController() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(vc, animated: true)
    }
    
    func updateViews(title: String, imageURL: URL?) {
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
