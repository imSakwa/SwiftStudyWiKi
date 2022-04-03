//
//  PrefetchTableCellTableViewCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/04/03.
//

import UIKit
import SnapKit
import Then

class PrefetchTableCellTableViewCell: UITableViewCell {

    let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgView.image = nil
    }
    
    func configure(viewModel: ViewModel, index: IndexPath) {
        viewModel.downloadImage(row: index.row) { [weak self] image in
            DispatchQueue.main.async {
                self?.imgView.image = image
            }
        }
    }
    

}
