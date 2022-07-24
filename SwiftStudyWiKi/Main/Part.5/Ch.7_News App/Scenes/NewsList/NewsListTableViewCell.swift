//
//  NewsListTableViewCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/17.
//

import SnapKit
import Then
import UIKit

final class NewsListTableViewCell: UITableViewCell {
    static let identifier = "NewsListTableViewCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .medium)
        $0.textColor = .secondaryLabel
    }
    
    func setup(news: News) {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        titleLabel.text = news.title
        descriptionLabel.text = news.description.htmlToString
        dateLabel.text = news.pubDate
    }
}

private extension NewsListTableViewCell {
    func setupLayout() {
        [titleLabel, descriptionLabel, dateLabel]
            .forEach { addSubview($0) }
        
        let superViewInset: CGFloat = 16.0
        let verticalSpacing: CGFloat = 4.0
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(48)
            $0.top.equalToSuperview().inset(superViewInset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
    }
}
