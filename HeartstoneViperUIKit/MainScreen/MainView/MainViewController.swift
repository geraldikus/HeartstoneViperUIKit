//
//  ViewController.swift
//  HeartstoneViperUIKit
//
//  Created by Anton on 22.02.24.
//

import UIKit
import Alamofire
import AlamofireImage

// ViewController
// Protocol
// reference presenter

protocol MainViewProtocol {
    var mainPresenter: MainPresenterProtocol? { get set }
    
    func updateData(with cards: [Cards])
}

class MainViewController: UIViewController, MainViewProtocol {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, Cards>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, Cards>
    
    var mainPresenter: MainPresenterProtocol?
    
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var dataSource: DataSource!
    private var snapshot: Snapshot!
    private var cards = [Cards]()
    private var sections = [Sections]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            
            let section = self?.sections[sectionIndex].race
            
            switch section {
            case "Race":
                return self?.createHorizontalSection()
            default:
                return nil
            }
        }
        return layout
    }

    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(300))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 20, bottom: 16, trailing: 12)
        
        let header = createSectionHeaderLayout()
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { [weak self] (collectionView, indexPath, card) -> UICollectionViewCell? in
            let raceSection = self?.sections[indexPath.section].race
            
            let imageURLString = card.img
            guard let imageURL = URL(string: imageURLString ?? "Empty") else {
                print("Wrong image url")
                print("ImageURL: \(String(describing: imageURLString))")
                return UICollectionViewCell()
            }
            
            switch raceSection {
            case "Race":
                return self?.configureCell(for: collectionView, at: indexPath, with: card, imageURL: imageURL)
            default:
                fatalError("Unknown race: \(String(describing: card.race))")
            }
        }
        
        snapshot = Snapshot()
        createHeader()
    }

    
    private func configureCell(for collectionView: UICollectionView, at indexPath: IndexPath, with card: Cards, imageURL: URL) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseId, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        
        cell.cardImage.af.setImage(withURL: imageURL, placeholderImage: UIImage(named: "heartstone"))
        cell.cardName.text = card.name
        cell.cardRace.text = card.race
        cell.backgroundColor = .gray.withAlphaComponent(0.1)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    private func appendSections() {
        let raceSection = Sections(race: "Race", items: cards)
        sections.append(raceSection)
    }

    private func createSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let layoutSectionHeaderSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1))
        
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        return layoutSectionHeader
    }
    
    private func createHeader() {
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { return UICollectionReusableView() }

            if let section = self?.sections[indexPath.section], let firstItem = section.items.first {
                sectionHeader.label.text = firstItem.race
            } else {
                sectionHeader.label.text = "No title"
            }
            
            return sectionHeader
        }
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
            self?.cards = cards
            self?.appendSections()
            self?.configureDataSource()
            self?.applySnapshot(with: cards)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedSection = sections[indexPath.section]
        let selectedCard = selectedSection.items[indexPath.item]
        
        print("Tapped name: \(selectedCard.name)")
        print("Tapped race: \(selectedCard.race)")
        print("Tapped ID: \(selectedCard.cardId)")
        
        let newScreen = DetailScreenViewController()
        newScreen.name = selectedCard.name
        newScreen.race = selectedCard.race
        
        navigationController?.pushViewController(newScreen, animated: true)
    }
}
