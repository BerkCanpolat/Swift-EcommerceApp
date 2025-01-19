//
//  DetailsPage.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 17.01.2025.
//

import UIKit
import RxSwift

class DetailsPage: UIViewController {
    
    var foods:Foods?
    var foodBasket:FoodBasketModels?
    var deneme = [FoodBasketModels]()
    var foodsModel = [Foods]()
    
    var viewModel = HomePageViewModel()
    var detailsViewModel = DetailsViewModel()
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    @IBOutlet weak var foodQuantitiyLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBOutlet weak var basketAction: UIButton!
        
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    private let disposeBage = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if let f = foods {
            self.navigationItem.title = "Ürün Detayları"
            if let img = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi ?? "ayran.png")") {
                imageView.kf.setImage(with: img)
            }
            self.foodPrice.text = "$ \(f.yemek_fiyat ?? "\(0)")"
            self.foodName.text = f.yemek_adi
        }
        
        /// HomeViewModel
        _ = viewModel.foodList.subscribe(onNext: { f in
            self.foodsModel = f
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBage)
        
        /// DetailsViewModel
        
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        basketAction.tintColor = UIColor(named: "buttonBasket")
        
        stepperOutlet.minimumValue = 1 // Minimum sipariş adedi
            stepperOutlet.maximumValue = 20 // Maksimum sipariş adedi
            stepperOutlet.value = 1 // Varsayılan değer
            foodQuantitiyLabel.text = "\(Int(stepperOutlet.value))" // Varsayılan olarak 1 gösterilir
        
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
        print("Add to basket button tapped")
        let quantity = Int(stepperOutlet.value) // Stepper'dan adet alınır
            print("Seçilen adet: \(quantity)")
        let alertController = UIAlertController(title: "Sepete Eklensin Mi?", message: "\(foods?.yemek_adi ?? "") - \(foods?.yemek_fiyat ?? "")", preferredStyle: .alert)
        
        let alertOkButton = UIAlertAction(title: "Ok", style: .default) { _ in
            if let f = self.foods {
                self.detailsViewModel.foodAddBasketViewModelFunction(yemek_adi: f.yemek_adi ?? "", yemek_resim_adi: f.yemek_resim_adi ?? "", yemek_fiyat: Int(f.yemek_fiyat ?? "") ?? 0, yemek_siparis_adet: quantity, kullanici_adi: "berk_canpolat")
            }
            
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
        return foodsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendCell", for: indexPath) as! RecommendCell
        cell.setup(foodsModel[indexPath.row])
        return cell
    }
    
}
