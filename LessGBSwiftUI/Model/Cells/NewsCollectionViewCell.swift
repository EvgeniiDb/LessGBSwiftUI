//
//  NewsCollectionViewCell.swift
//  LessGBSwiftUI
//
//  Created by Евгений Доброволец on 08.09.2022.
//

import UIKit

// Класс ячейки фотографии для новости
final class NewsCollectionViewCell: UICollectionViewCell {
    
    // Основная вью с картинкой
    private let newsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // ReuseIdentifier для ячейки коллекции новостей
    let reuseIdentifier = "NewsCollectionViewCell"
    
    // Конфигурирует ячейку
    func configure(with image: UIImage) {
        contentView.addSubview(newsImage)
        newsImage.image = image
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    override func prepareForReuse() {
        newsImage.image = nil
    }
}

