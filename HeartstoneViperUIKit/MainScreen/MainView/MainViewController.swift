//
//  ViewController.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import UIKit

// ViewController
// Protocol
// reference presenter

protocol MainViewProtocol {
    var mainPresenter: MainPresenterProtocol? { get set }
    
    func updateData(with cards: [Cards], for race: Endpoints)
    func updateData(with error: [Error])
}

class MainViewController: UIViewController, MainViewProtocol {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Endpoints, Cards>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Endpoints, Cards>
    
    var mainPresenter: MainPresenterProtocol?
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    var dataForRaces: [Endpoints: [Cards]] = [:]
    var section = [Endpoints]()
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        configureDataSource()
        print("View is loaded")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .green
        view.addSubview(collectionView)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layotEnvironment in
            
            //let section = self.section[sectionIndex]
            return self.createHorizontalSection()
        }
        
        return layout
    }
    
    func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(104), heightDimension: .estimated(88))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 6, trailing: 12)
        
        //let header = createSectionHeader()
        
      //  section.boundarySupplementaryItems = [header]
        return section
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, card) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell
            cell?.beastName.text = card.name
            cell?.backgroundColor = .yellow
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections(section)
        for race in section {
            snapshot.appendItems(dataForRaces[race] ?? [], toSection: race)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateData(with cards: [Cards], for race: Endpoints) {
        print("Got data for \(race)")
        DispatchQueue.main.async { [weak self] in
            self?.dataForRaces[race] = cards
            self?.applySnapshot()
            self?.mainPresenter?.interactorDidFetchData(with: .success(cards), for: race)
        }
    }
    
    func updateData(with error: [Error]) {
        print("Something went wrong")
    }
}

