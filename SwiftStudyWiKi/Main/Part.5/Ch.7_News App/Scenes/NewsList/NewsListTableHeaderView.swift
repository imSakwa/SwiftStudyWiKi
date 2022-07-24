//
//  NewsListTableHeaderView.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/24.
//

import UIKit
import SnapKit
import Then

final class NewsListTableHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsListTableHeaderView"
    
    private var tags: [String] = ["IT", "아이폰", "개발", "개발자", "앱개발", "강남", "스타트업", "판교"]
    
//    private lazy var tagCollectionView = TTGTextTagCollectionView().then {
//        $0.numberOfLines = 1
//        $0.scrollDirection = .horizontal
//        $0.showsHorizontalIndicator = false
//        $0.selectionLimit = 1
//
//        let insetValue: CGFloat = 16.0
//        $0.contentInset = UIEdgeInsets(
//            top: insetValue,
//            left: insetValue,
//            bottom: insetValue,
//            right: insetValue
//        )
//
//        let cornerRadiusValue: CGFloat = 12.0
//        let shadowOpacity: CGFloat = 0.0
//        let extraSpace = CGSize(width: 20.0, height: 12.0)
//        let color = UIColor.systemOrange
//
//        let style = TTGTextTagStyle().then {
//            $0.backgroundColor = color
//            $0.cornerRadius = cornerRadiusValue
//            $0.borderWidth = 0
//            $0.shadowOpacity = shadowOpacity
//            $0.extraSpace = extraSpace
//        }
//
//        let selectedStyle = TTGTextTagStyle().then {
//            $0.backgroundColor = .white
//            $0.cornerRadius = cornerRadiusValue
//            $0.borderColor = color
//            $0.shadowOpacity = shadowOpacity
//            $0.extraSpace = extraSpace
//        }
//
//        tags.forEach { tag in
//            let font = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
//            let tagContent = TTGTextTagStringContent(
//                text: tag,
//                textFont: font,
//                textColor: .white
//            )
//            let selectedTagContents = TTGTextTagStringContent(
//                text: tag,
//                textFont: font,
//                textColor: color
//            )
//
//            let tag = TTGTextTag(
//                content: tagContent,
//                style: style,
//                selectedContents: selectedTagContents,
//                selectedStyle: selectedStyle
//            )
//        }
//        $0.addTag(tag)
//    }
    
    func setup() {
        contentView.backgroundColor = .systemBackground
        
        setupTagCollectionViewLayout()
    }
}

//extension NewsListTableHeaderView: TTGta

private extension NewsListTableHeaderView {
    func setupTagCollectionViewLayout() {
//        addSubview(tagCollectionView)
//
//        tagCollectionView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
}
