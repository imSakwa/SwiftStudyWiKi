//
//  SubjectTableCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/27.
//

import UIKit

import SnapKit

final class SubjectTableCell: UITableViewCell {
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var nextIcon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.black)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setLayout()
    }
    
    func setupData(data: String) {
        titleLbl.text = data
    }
    
    private func setLayout() {
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        addSubview(nextIcon)
        nextIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
