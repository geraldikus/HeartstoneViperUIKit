//
//  DemonCollectionViewCell.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 27.02.24.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CardCell"
    
    let cardName: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let cardRace: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let cardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(cardImage)
        contentView.addSubview(cardName)
        contentView.addSubview(cardRace)
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cardImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cardImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cardImage.heightAnchor.constraint(equalToConstant: 220),
            
            cardName.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            cardName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cardRace.topAnchor.constraint(equalTo: cardName.bottomAnchor, constant: 10),
            cardRace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
