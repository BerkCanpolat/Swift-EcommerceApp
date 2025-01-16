//
//  HomePageViewModel.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 16.01.2025.
//

import Foundation
import RxSwift

class HomePageViewModel {
    var foodRepo = FoodsRepository()
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init() {
        foodList = foodRepo.foodsList
        foodFetch()
    }
    
    func foodFetch() {
        foodRepo.foodsGet()
    }
}
