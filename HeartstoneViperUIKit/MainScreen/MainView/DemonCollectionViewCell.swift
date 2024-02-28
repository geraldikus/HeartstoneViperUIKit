//
//  DemonCollectionViewCell.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 27.02.24.
//

import UIKit

class DemonsCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "DemonCell"
    
    let demonName: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let demonRace: UILabel = {
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
        contentView.addSubview(demonName)
        contentView.addSubview(demonRace)
        
        NSLayoutConstraint.activate([
            demonName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            demonName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            demonRace.topAnchor.constraint(equalTo: demonName.bottomAnchor, constant: 10),
            demonRace.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
