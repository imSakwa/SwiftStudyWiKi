//
//  SubjectTableCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/02/27.
//

import UIKit
import SnapKit
import Then

class SubjectTableCell: UITableViewCell {
    
    let titleLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 17)
    }
    
    let nextIcon = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    private func setLayout() {
        
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        self.addSubview(nextIcon)
        nextIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
