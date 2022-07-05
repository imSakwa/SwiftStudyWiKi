//
//  BookmarkCollectionViewCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/05.
//

import SnapKit
import UIKit
import Then

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView: BookmarkTextStackView!
    private var targetBookmarkTextStackView: BookmarkTextStackView!
    
    private lazy var stackView = UIStackView().then { view in
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.spacing = 16
        
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
    }
    
    func setup(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(language: bookmark.sourceLanguage, text: bookmark.sourceText, type: .source)
        targetBookmarkTextStackView = BookmarkTextStackView(language: bookmark.translatedLanguage, text: bookmark.translatedText, type: .target)
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView]
            .forEach { stackView.addArrangedSubview($0) }
        
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 32)
        }
        
        layoutIfNeeded()
    }
}
