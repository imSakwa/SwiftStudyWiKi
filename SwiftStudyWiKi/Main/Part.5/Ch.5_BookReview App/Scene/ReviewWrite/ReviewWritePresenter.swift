//
//  ReviewWritePresenter.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/09.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
}

final class ReviewWritePresenter {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
        
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
        
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton() {
        // TODO: UserDefault에 유저가 작성한 도서 리뷰 저장하기
        viewController.close()
    }
}
