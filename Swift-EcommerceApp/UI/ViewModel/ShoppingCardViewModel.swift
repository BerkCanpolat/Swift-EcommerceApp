//
//  ShoppingCardViewModel.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 18.01.2025.
//

import Foundation
import RxSwift


class ShoppingCardViewModel {
    var foodRepo = FoodsRepository()
    var foodAddBasketViewModelList = BehaviorSubject<[FoodBasketModels]>(value: [FoodBasketModels]())
    
    init() {
        foodAddBasketViewModelList = foodRepo.foodBasket
        foodBasketGetViewModel(kullanici_adi: "berk_canpolat")
    }
    
    func foodBasketGetViewModel(kullanici_adi:String) {
        foodRepo.foodsBasketGet(kullanici_adi: kullanici_adi)
    }
    
    func foodBasketDeleteViewModel(sepet_yemek_id:Int,kullanici_adi:String) {
        foodRepo.foodsBasketDelete(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    
    func updateFoodQuantityInBasket(sepet_yemek_id: Int, yeni_adet: Int) {
            print("Sepetteki yemek id: \(sepet_yemek_id) yeni adet: \(yeni_adet)")
        }
    
}
