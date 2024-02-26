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
    var section: [Endpoints] = Endpoints.allRaces
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        configureDataSource()
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
            
            let section = self.section[sectionIndex]
            
            return self.createHorizontalSection()
        }
        
        return layout
    }
    
    func createHorizontalSection() -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 6, trailing: 3)
        
        //let header = createSectionHeader()
        
        //section.boundarySupplementaryItems = [header]
        return section
    }



    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, card) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseId, for: indexPath) as? MainCollectionViewCell else {
                print("Cannot create cell")
                return UICollectionViewCell()
            }
            cell.beastName.text = card.name
            cell.backgroundColor = .yellow
            cell.layer.cornerRadius = 10
            return cell
        }
        applySnapshot()
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
            print("Data is ok.")
            if let strongSelf = self {
                strongSelf.applySnapshot()
                strongSelf.collectionView.reloadData()
            } else {
                print("Something get wrong")
            }
        }
    }

    
    func updateData(with error: [Error]) {
        print("Something went wrong")
    }
}

