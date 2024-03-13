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
    var image: UIImage? { get set }
    var attack: Int? { get set }
    var health: Int? { get set }
    
    func updateData(with image: UIImage)
}

class DetailScreenViewController: UIViewController, DetailViewProtocol {
    
    var detailPresenter: DetailPresenterProtocol?
    
    var name: String?
    var race: String?
    var image: UIImage?
    var attack: Int?
    var health: Int?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let raceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Attack"
        return label
    }()
    
    let healthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Health"
        return label
    }()
    
    let attackValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let healthValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(raceLabel)
        contentView.addSubview(cardImage)
        contentView.addSubview(attackLabel)
        contentView.addSubview(healthLabel)
        contentView.addSubview(attackValueLabel)
        contentView.addSubview(healthValueLabel)
        
        nameLabel.text = name
        raceLabel.text = race
        cardImage.image = image
        attackValueLabel.text = "\(String(describing: attack))"
        healthValueLabel.text = "\(String(describing: health))"
    }
    
    private func setupConstraints() {
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            cardImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cardImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardImage.heightAnchor.constraint(equalToConstant: 220),
            cardImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            raceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            raceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            attackLabel.topAnchor.constraint(equalTo: raceLabel.bottomAnchor, constant: 20),
            attackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            healthLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: 10),
            healthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            attackValueLabel.topAnchor.constraint(equalTo: raceLabel.bottomAnchor, constant: 20),
            attackValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            healthValueLabel.topAnchor.constraint(equalTo: attackValueLabel.bottomAnchor, constant: 10),
            healthValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            healthValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func updateData(with image: UIImage) {
        
    }
}
