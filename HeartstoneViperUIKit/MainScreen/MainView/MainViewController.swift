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
    
    func updateData(with cards: [Cards])
    func updateData(with error: [Error])
}

class MainViewController: UIViewController, MainViewProtocol {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Cards>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Cards>
    
    var mainPresenter: MainPresenterProtocol?
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    var dataSource: DataSource!
    var snapshot: Snapshot!
    var cards = [Cards]()
    var sections = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
        configureDataSource()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.register(BeastCollectionViewCell.self, forCellWithReuseIdentifier: BeastCollectionViewCell.reuseId)
        collectionView.register(DemonsCollectionViewCell.self, forCellWithReuseIdentifier: DemonsCollectionViewCell.reuseId)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
           
            let section = self?.sections[sectionIndex].race
            
            switch section {
            case "Beast", "Demon":
                return self?.createHorizontalSection()
            default:
                return nil
            }
        }
        return layout
    }

    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(400))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 6, trailing: 3)
        section.interGroupSpacing = 5
        
        return section
    }

    func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { [weak self] (collectionView, indexPath, card) -> UICollectionViewCell? in
            guard let self = self else { return nil }
            
            let raceSection = sections[indexPath.section].race
            
            switch raceSection {
            case "Beast":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeastCell", for: indexPath) as! BeastCollectionViewCell
                cell.beastName.text = card.name
                cell.beastRace.text = card.race
                cell.backgroundColor = .gray.withAlphaComponent(0.3)
                cell.layer.cornerRadius = 10
                return cell
            case "Demon":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemonCell", for: indexPath) as! DemonsCollectionViewCell
                cell.demonName.text = card.name
                cell.demonRace.text = card.race
                cell.backgroundColor = .gray.withAlphaComponent(0.3)
                cell.layer.cornerRadius = 10
                return cell
            default:
                fatalError("Unknown race: \(String(describing: card.race))")
            }
        }
        snapshot = Snapshot()
        applySnapshot(with: cards)
    }
    
    private func appendSections() {
        let beastSection = Sections(race: "Beast", items: cards)
        let demonSection = Sections(race: "Demon", items: cards)
        
        sections.append(beastSection)
        sections.append(demonSection)
        
        print("Sections: \(sections)")
    }

    
    private func applySnapshot(with cards: [Cards]) {
        guard let dataSource = dataSource else { return }
        snapshot.deleteAllItems()
        snapshot.appendSections(sections)
        
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
        print("Cards: \(cards)")
    }
    
    func updateData(with cards: [Cards]) {
        print("Got data for Cards count: \(cards.count)")
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cards = cards
            appendSections()
            self.applySnapshot(with: cards)
        }
    }
    
    func updateData(with error: [Error]) {
        print("Something went wrong")
    }
}

struct Sections: Hashable {
    let race: String
    let items: [Cards]
}
