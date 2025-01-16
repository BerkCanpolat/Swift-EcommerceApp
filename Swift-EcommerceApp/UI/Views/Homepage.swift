//
//  Homepage.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class Homepage: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var foods:[Foods] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = mainLayout()
    }
    
    private func mainLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (index, environment) -> NSCollectionLayoutSection? in
            
            return self?.createdSectionLayout(index: index, environment: environment)
        }
        return layout
    }
    
    private func createdSectionLayout(index:Int, environment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            return createdFirstSection()
        case 1:
            return createdSecondSection()
        case 2:
            return createdThirtSection()
        default:
            return createdFirstSection()
        }
    }
    
    private func createdFirstSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [createSuplementaryHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
        return section
    }
    
    private func createdSecondSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSuplementaryHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func createdThirtSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [createSuplementaryHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func createSuplementaryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    

    

}

extension Homepage: UICollectionViewDelegate, UICollectionViewDataSource, FiltersReusableProtocol {
    func filtersFunction(index: IndexPath) {
        print("Oldu mu la gardas")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return mockLandingData.count
        case 1: return mockCategoriesData.count
        case 2: return foods.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartLandingCell", for: indexPath) as! LandingCollectionCell
            cell.setup(mockLandingData[indexPath.row])
            // Kart tasarımı
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor // Kenarlık rengi
            cell.layer.cornerRadius = 10 // Yuvarlatılmış köşeler
            cell.layer.masksToBounds = true // Taşan içeriği kes
            cell.contentView.backgroundColor = UIColor.white // Arka plan rengi
            return cell
        
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartCategoriCell", for: indexPath) as! CategoriesCollectionCell
            cell.setup(mockCategoriesData[indexPath.row])
            return cell
        
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartProductCell", for: indexPath) as! ProdCollectionCell
            cell.setup(foods[indexPath.row])
            
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let layout = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeReusableCell", for: indexPath) as! HomeReusableCell
            switch indexPath.section {
            case 0:
                layout.setup("", showButton: true)
            case 1:
                layout.setup("Category", showButton: true)
            case 2:
                layout.setup("Recent Product", showButton: false)
                layout.reusableIndexPath = indexPath
                layout.reusableFiltersProtocol = self
            default:
                layout.setup("Geçersiz")
            }
            return layout
        default:
            return UICollectionReusableView()
        }
    }
}
