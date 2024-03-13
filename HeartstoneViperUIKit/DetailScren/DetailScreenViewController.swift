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
    
    func updateData(with image: UIImage)
}

class DetailScreenViewController: UIViewController, DetailViewProtocol {
    
    var detailPresenter: DetailPresenterProtocol?
    
    var name: String?
    var race: String?
    var image: UIImage?
    
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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(raceLabel)
        self.contentView.addSubview(cardImage)
        
        nameLabel.text = name
        raceLabel.text = race
        cardImage.image = image
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.5)
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
            hConst,
            
            
            cardImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cardImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardImage.heightAnchor.constraint(equalToConstant: 220),
            
            nameLabel.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            raceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            raceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
         //   raceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }


    
    func updateData(with image: UIImage) {
        
    }
}
