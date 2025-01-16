//
//  FoodsRepository.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 16.01.2025.
//

import Foundation
import RxSwift
import Alamofire

class FoodsRepository {
    var foodsList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    func foodsGet() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php", method: .get).response { response in
            if let data = response.data {
                do{
                    let answer = try JSONDecoder().decode(FoodsAnswer.self, from: data)
                    if let callAnswer = answer.yemekler {
                        self.foodsList.onNext(callAnswer)
                    }
                } catch {
                    print("Foods error")
                }
            }
        }
    }
    
}
