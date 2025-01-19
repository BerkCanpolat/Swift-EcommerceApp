//
//  ShoppingCartPage.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 18.01.2025.
//

import UIKit
import RxSwift

class ShoppingCartPage: UIViewController {
    
    @IBOutlet weak var foodTotalLabel: UILabel!
    @IBOutlet weak var foodTotalPriceLabel: UILabel!
    @IBOutlet weak var selectPaymentOutlet: UIButton!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var foodBasketModel = [FoodBasketModels]()
    let shoppingViewModel = ShoppingCardViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectPaymentOutlet.tintColor = UIColor(named: "buttonBasket")
        
        _ = shoppingViewModel.foodAddBasketViewModelList.subscribe(onNext: {getBasket in
            self.foodBasketModel = getBasket
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateTotalPrice()
            }
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func selectPaymentMethodButton(_ sender: UIButton) {
    }
    
    func updateTotalPrice() {
        var totalPrice: Double = 0
        
        for food in foodBasketModel {
            if let price = Double(food.yemek_fiyat), let quantity = Int(food.yemek_siparis_adet) {
                totalPrice += price * Double(quantity)
            }
        }
        
        foodTotalPriceLabel.text = "₺ \(String(format: "%.2f", totalPrice))"
    }


}

extension ShoppingCartPage: UITableViewDelegate, UITableViewDataSource, ProtocolFoodDelete {
    func foodQuantitiyPlusPro(indexPath: IndexPath, quantity: Int) {
        print("Plus Basıldı")
            
            let food = foodBasketModel[indexPath.row]
            
            if let adet = Int(food.yemek_siparis_adet) {
                food.yemek_siparis_adet = "\(adet + 1)"
                
                if let cell = tableView.cellForRow(at: indexPath) as? ShoppingCartCell {
                    cell.foodQuantitiyLabel.text = "Quantity: \(food.yemek_siparis_adet)"
                }
                
                foodBasketModel[indexPath.row] = food
                
                if let yeniAdet = Int(food.yemek_siparis_adet) {
                    shoppingViewModel.updateFoodQuantityInBasket(sepet_yemek_id: Int(food.sepet_yemek_id) ?? 0, yeni_adet: yeniAdet)
                }
                
                updateTotalPrice()
            }
    }
    
    func foodQuantitiyMinusPro(indexPath: IndexPath, quantity: Int) {
        print("Minus Basıldı")
            
            let food = foodBasketModel[indexPath.row]
            
            if let adet = Int(food.yemek_siparis_adet), adet > 1 {
                food.yemek_siparis_adet = "\(adet - 1)"
                
                if let cell = tableView.cellForRow(at: indexPath) as? ShoppingCartCell {
                    cell.foodQuantitiyLabel.text = "Quantity: \(food.yemek_siparis_adet)"
                }
                
                foodBasketModel[indexPath.row] = food
                
                if let yeniAdet = Int(food.yemek_siparis_adet) {
                    shoppingViewModel.updateFoodQuantityInBasket(sepet_yemek_id: Int(food.sepet_yemek_id) ?? 0, yeni_adet: yeniAdet)
                }
                updateTotalPrice()
            }
    }
    
    func foodDeletePro(indexPath: IndexPath) {
        print("Delete Basıldı")
        let foodIndex = foodBasketModel[indexPath.row]
        shoppingViewModel.foodBasketDeleteViewModel(sepet_yemek_id: Int(foodIndex.sepet_yemek_id) ?? 0, kullanici_adi: "berk_canpolat")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodBasketModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingCartCell
        cell.setup(foodBasketModel[indexPath.row])
        cell.selectionStyle = .none
        
        cell.tableViewIndex = indexPath
        cell.tableViewPro = self
        cell.tableViewMinus = 0
        cell.tableViewPlus = 0
        return cell
    }
}
