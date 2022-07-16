//
//  MovieListCollectionViewCell.swift
//  SwiftStudyWiKi
//
//  Created by ChangMin on 2022/07/16.
//

import SnapKit
import Then
import UIKit
import Kingfisher

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .secondarySystemBackground
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13.0, weight: .semibold)
    }
    
    private lazy var userRatingLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13.0, weight: .medium)
    }
    
    func update(_ movie: Movie) {
        setupView()
        setupLayout()
        
        imageView.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title
        userRatingLabel.text = "⭐️ \(movie.userRating)"
    }
}

private extension MovieListCollectionViewCell {
    func setupView() {
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8.0
        
        backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        [imageView, titleLabel, userRatingLabel]
            .forEach { addSubview($0) }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(imageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(imageView)
        }
        
        userRatingLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(imageView)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
