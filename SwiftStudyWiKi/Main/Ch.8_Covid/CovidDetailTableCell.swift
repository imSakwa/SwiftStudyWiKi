//
//  CovidDetailTableCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/04.
//

import UIKit


class CovidDetailTableCell: UITableViewCell {

    let titleLbl = UILabel().then {
        $0.text = "1111"
    }
    
    let numLbl = UILabel().then {
        $0.text = "2222"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLbl)
        contentView.addSubview(numLbl)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        numLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }

}
