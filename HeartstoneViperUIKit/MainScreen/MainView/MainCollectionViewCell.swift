//
//  MainCollectionViewCell.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "BeastCell"
    
    let beastName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    private func setupCell() {
        contentView.addSubview(beastName)
        
        NSLayoutConstraint.activate([
            beastName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            beastName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
