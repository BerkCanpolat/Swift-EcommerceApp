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
    var foodBasket = BehaviorSubject<[FoodBasketModels]>(value: [FoodBasketModels]())
    
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
    
    
    func foodsBasketAdd(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:Int, yemek_siparis_adet:Int, kullanici_adi:String) {
        let parameters:Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php", method: .post, parameters: parameters).response { response in
            if let data = response.data {
                do {
                    let addBasket = try JSONDecoder().decode(FoodBasketAnswerModel.self, from: data)
                    print("Sepete Eklendi : \(addBasket)")
                    print("Success: \(String(describing: addBasket.success))")
                    print("Message: \(String(describing: addBasket.message))")
                } catch {
                    print("EWRROR FOOD ADD BASKET")
                    print(error)
                }
            }
        }
    }
    
    func foodsBasketGet(kullanici_adi:String) {
        let parametre:Parameters = ["kullanici_adi":kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: parametre).response { response in
            guard let data = response.data else {
                print("GUARDA GİRİLDİ.")
                self.foodBasket.onNext([FoodBasketModels]()) // Boş liste dönüyoruz
                return
            }
            
            // Raw JSON yanıtını yazdırmak
            print("Raw JSON Response: \(String(data: data, encoding: .utf8) ?? "No Data")")
            
            // Eğer data boşsa veya geçerli bir JSON değilse
            if data.isEmpty || (String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true) {
                print("Json boş veya geçersiz")
                self.foodBasket.onNext([FoodBasketModels]()) // Boş liste dönüyoruz
                return
            }
            
            // Eğer geçerli bir JSON ise, çözümleme işlemi
            do {
                let getFoodBasket = try JSONDecoder().decode(FoodBasketAnswerModel.self, from: data)
                if let basketFoodGet = getFoodBasket.sepet_yemekler, !basketFoodGet.isEmpty {
                    self.foodBasket.onNext(basketFoodGet) // Sepet yemekleri varsa gönder
                } else {
                    print("Sepet boş")
                    self.foodBasket.onNext([FoodBasketModels]()) // Sepet boşsa boş liste dönüyoruz
                }
            } catch {
                print("Sepetteki yemekler getirilemedi")
                print("JSON Decode Error: \(error.localizedDescription)")
                self.foodBasket.onNext([FoodBasketModels]()) // Hata durumunda boş liste dönüyoruz
            }
        }
    }
    
    
    func foodsBasketDelete(sepet_yemek_id:Int, kullanici_adi:String) {
        let parametre:Parameters = ["sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php", method: .post, parameters: parametre).response {response in
            if let data = response.data {
                do {
                    let deleteFood = try JSONDecoder().decode(FoodBasketAnswerModel.self, from: data)
                    self.foodsBasketGet(kullanici_adi: "berk_canpolat")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
