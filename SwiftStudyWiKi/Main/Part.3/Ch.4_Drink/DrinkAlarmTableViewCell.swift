//
//  DrinkAlarmTableViewCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/05/08.
//

import UIKit
import Then
import SnapKit

class DrinkAlarmTableViewCell: UITableViewCell {

    let amLbl = UILabel().then {
        $0.text = "오전"
        $0.font = .systemFont(ofSize: 28, weight: .light)
    }
    
    let timeLbl = UILabel().then {
        $0.text = "00:00"
        $0.font = .systemFont(ofSize: 50, weight: .light)
    }
    
    let onoffSwitch = UISwitch().then {
        $0.addTarget(self, action: #selector(changeOnOff), for: .valueChanged)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    @objc private func changeOnOff(_ sender: UISwitch) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(amLbl)
        contentView.addSubview(timeLbl)
        contentView.addSubview(onoffSwitch)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        amLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(timeLbl.snp.bottom).offset(8)
        }
        
        timeLbl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(amLbl.snp.trailing)
        }
        
        onoffSwitch.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
