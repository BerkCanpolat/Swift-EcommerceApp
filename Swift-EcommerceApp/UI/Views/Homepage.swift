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
    
    private let mockData = MockData.shared.pageData
    
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
        return section
    }
    
    private func createSuplementaryHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    

    

}

extension Homepage: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch mockData[indexPath.section] {
        case .cartLanding(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartLandingCell", for: indexPath) as! LandingCollectionCell
            cell.setup(item[indexPath.row])
            // Kart tasarımı
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.lightGray.cgColor // Kenarlık rengi
            cell.layer.cornerRadius = 10 // Yuvarlatılmış köşeler
            cell.layer.masksToBounds = true // Taşan içeriği kes
            cell.contentView.backgroundColor = UIColor.white // Arka plan rengi
            return cell
        
        case .cartCategories(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartCategoriCell", for: indexPath) as! CategoriesCollectionCell
            cell.setup(item[indexPath.row])
            return cell
        
        case .cartProduct(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartProductCell", for: indexPath) as! ProdCollectionCell
            cell.setup(item[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let layout = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeReusableCell", for: indexPath) as! HomeReusableCell
            switch indexPath.section {
            case 0:
                layout.setup("")
            case 1:
                layout.setup("Category")
            case 2:
                layout.setup("Recent Product")
            default:
                layout.setup("Geçersiz")
            }
            return layout
        default:
            return UICollectionReusableView()
        }
    }
}
