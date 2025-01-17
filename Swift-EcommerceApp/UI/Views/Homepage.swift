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
    private var homeViewModel = HomePageViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = mainLayout()
        
        _ = homeViewModel.foodList.subscribe(onNext: { foodsViewModel in
            self.foods = foodsViewModel
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 20, trailing: 0)
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
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
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
    
    
    
    private func sortFoodsByPrice() {
        foods.sort { (food1, food2) -> Bool in
            guard let price1 = Int(food1.yemek_fiyat ?? "0"),
                  let price2 = Int(food2.yemek_fiyat ?? "0") else { return false }
            return price1 < price2
        }
    }

    private func sortFoodsAlphabetically() {
        foods.sort { (food1, food2) -> Bool in
            return (food1.yemek_adi ?? "").localizedCaseInsensitiveCompare(food2.yemek_adi ?? "") == .orderedAscending
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsPage" {
            if let indeks = sender as? Foods {
                let gidilecekVC = segue.destination as! DetailsPage
                gidilecekVC.deneme = indeks
            }
        }
    }
    

    

}

extension Homepage: UICollectionViewDelegate, UICollectionViewDataSource, FiltersReusableProtocol {
    func filtersFunction(index: IndexPath) {
        let alertController = UIAlertController(title: "Filters Options", message: nil, preferredStyle: .actionSheet)
        
        let alertPriceSort = UIAlertAction(title: "Fiyata Göre Sırala", style: .default) { _ in
            self.sortFoodsByPrice()
            self.collectionView.reloadData()
        }
        
        let alphabeticSort = UIAlertAction(title: "Alfabeye Göre Sırala", style: .default) { _ in
            self.sortFoodsAlphabetically()
            self.collectionView.reloadData()
        }
        
        let alertCancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
        
        alertController.addAction(alertPriceSort)
        alertController.addAction(alphabeticSort)
        alertController.addAction(alertCancel)
        present(alertController, animated: true)
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
            cell.layer.masksToBounds = false // Taşan içeriği kes
            //cell.contentView.backgroundColor = UIColor(named: "backGround") // Arka plan rengi
            
            // Gölge ekleme
                    cell.layer.shadowColor = UIColor.blue.cgColor // Gölgenin rengi
                    cell.layer.shadowOpacity = 0.2 // Gölgenin opaklığı (0.0 ile 1.0 arasında)
                    cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Gölgenin konumu
                    cell.layer.shadowRadius = 5 // Gölgenin bulanıklık yarıçapı
            
            // İçerik arka planı (gölgeye etki etmez)
                    cell.contentView.layer.cornerRadius = 10
            cell.contentView.backgroundColor = UIColor.white
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tabBarController?.tabBar.isHidden = true
        let foodsIndex = foods[indexPath.row]
        performSegue(withIdentifier: "detailsPage", sender: foodsIndex)
        print("Üstüne bsaıldı")
    }

}
