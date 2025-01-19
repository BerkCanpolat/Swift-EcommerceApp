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
        foodBasketGetViewModel(kullanici_adi: "he")
    }
    
    func foodBasketGetViewModel(kullanici_adi:String) {
        foodRepo.foodsBasketGet(kullanici_adi: kullanici_adi)
    }
    
}
