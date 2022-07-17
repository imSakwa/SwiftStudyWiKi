//
//  MovieContentStackView.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/17.
//

import SnapKit
import UIKit

final class MovieContentStackView: UIStackView {
    private let title: String
    private let contents: String
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
        $0.text = title
    }
    
    private lazy var contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.text = contents
    }
    
    init(title: String, contents: String) {
        self.title = title
        self.contents = contents
        
        super.init(frame: .zero)
        
        axis = .horizontal
        [titleLabel, contentsLabel]
            .forEach { addArrangedSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
