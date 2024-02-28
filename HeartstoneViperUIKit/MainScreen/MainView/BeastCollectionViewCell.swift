//
//  MainCollectionViewCell.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import UIKit

class BeastCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "BeastCell"
    
    let beastName: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let beastRace: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(beastName)
        contentView.addSubview(beastRace)
        
        NSLayoutConstraint.activate([
            beastName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            beastName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            beastRace.topAnchor.constraint(equalTo: beastName.bottomAnchor, constant: 10),
            beastRace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
