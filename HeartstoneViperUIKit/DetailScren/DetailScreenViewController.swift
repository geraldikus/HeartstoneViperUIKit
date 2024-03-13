//
//  NewScreen.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 12.03.24.
//

import UIKit

protocol DetailViewProtocol {
    
    var detailPresenter: DetailPresenterProtocol? { get set }
    var name: String? { get set }
    var race: String? { get set }
    
    func updateData(with image: UIImage)
}

class DetailScreenViewController: UIViewController, DetailViewProtocol {
    
    var detailPresenter: DetailPresenterProtocol?
    
    var name: String?
    var race: String?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let raceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupView()
    }
    
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(raceLabel)
        view.addSubview(cardImage)
        
        nameLabel.text = name
        raceLabel.text = race
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            cardImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            cardImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            cardImage.heightAnchor.constraint(equalToConstant: 220),
            
            nameLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            raceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            raceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func updateData(with image: UIImage) {
        
    }
}
