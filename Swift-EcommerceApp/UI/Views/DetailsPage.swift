//
//  DetailsPage.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 17.01.2025.
//

import UIKit

class DetailsPage: UIViewController {
    
    var deneme:Foods?
    var deneme2 = [Foods]()
    
    var deneme3 = HomePageViewModel()
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    
    @IBOutlet weak var foodQuantitiyLabel: UILabel!
    
    @IBOutlet weak var stepperOutlet: UIStepper!
    
        
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let f = deneme {
            self.navigationItem.title = f.yemek_adi
            if let img = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi ?? "ayran.png")") {
                imageView.kf.setImage(with: img)
            }
            self.foodPrice.text = "$ \(f.yemek_fiyat ?? "\(0)")"
            self.foodName.text = f.yemek_adi
        }
        
        _ = deneme3.foodList.subscribe(onNext: { f in
            self.deneme2 = f
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        })
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
    }
    
       private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
           return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
               
               // Hücre boyutu (widthFraction ve heightFraction ayarlanır)
               let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
               let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
               // Hücreler arası boşluk
               item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
               
               // Grup boyutu (yatay bir grup oluşturulur)
               let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(75))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
               
               // Grup içindeki öğeler arası mesafe
               group.interItemSpacing = .fixed(10)
               
               // Bölüm
               let section = NSCollectionLayoutSection(group: group)
               section.orthogonalScrollingBehavior = .continuous // Yatay kaydırma
               
               return section
           }
       }
    
    
    @IBAction func foodFavoriteButton(_ sender: Any) {
    }
    
    
    @IBAction func foodAddBasketButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Sepete Eklensin Mi?", message: "\(deneme?.yemek_adi ?? "") - \(deneme?.yemek_fiyat ?? "")", preferredStyle: .alert)
        
        let alertOkButton = UIAlertAction(title: "Ok", style: .default) { _ in
            print("Ok basıldı")
            
            let alertControllerTwo = UIAlertController(title: "Sepete Eklendi!", message: "Ürününüz sepete eklenmiştir. Lütfen sepetinizi kontrol edin.", preferredStyle: .alert)
            
            let alertOKBasketButton = UIAlertAction(title: "OK", style: .destructive) {_ in
            }
            
            alertControllerTwo.addAction(alertOKBasketButton)
            self.present(alertControllerTwo, animated: true)
            
        }
        
        let alertCancelButton = UIAlertAction(title: "Cancel", style: .destructive) { _ in
            print("Cancela basıldı")
        }
        
        alertController.addAction(alertOkButton)
        alertController.addAction(alertCancelButton)
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func foodStepperButton(_ sender: UIStepper) {
        foodQuantitiyLabel.text = String(Int(sender.value))
    }
    
}


extension DetailsPage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deneme2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCell
        cell.setup(deneme2[indexPath.row])
        return cell
    }
    
}
