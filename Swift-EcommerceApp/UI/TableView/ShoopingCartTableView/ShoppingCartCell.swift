//
//  ShoppingCartCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 18.01.2025.
//

import UIKit
import Kingfisher

protocol ProtocolFoodDelete {
    func foodDeletePro(indexPath:IndexPath)
    func foodQuantitiyMinusPro(indexPath:IndexPath, quantity:Int)
    func foodQuantitiyPlusPro(indexPath:IndexPath, quantity:Int)
}

class ShoppingCartCell: UITableViewCell {
    
    
    @IBOutlet weak var foodSelectButton: UIButton!
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodQuantitiyLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    var tableViewPro:ProtocolFoodDelete?
    var tableViewIndex:IndexPath?
    var tableViewMinus:Int?
    var tableViewPlus:Int?
    
    func setup(_ food:FoodBasketModels) {
        if let img = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi)") {
            foodImage.kf.setImage(with: img)
        }
        foodName.text = food.yemek_adi
        foodPriceLabel.text = "₺ \(food.yemek_fiyat)"
        foodQuantitiyLabel.text = "Quantity: \(food.yemek_siparis_adet)"
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func foodSelectedButton(_ sender: UIButton) {
        // Butonun seçili durumunu değiştir
            sender.isSelected.toggle()

            // Seçili durumuna göre renk ve simge değiştir
            if sender.isSelected {
                sender.tintColor = UIColor(named: "buttonBasket") // Yeşil renk
                sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                sender.tintColor = UIColor.gray // Gri renk
                sender.setImage(UIImage(systemName: "circle"), for: .normal)
            }
    }
    
    
    @IBAction func foodMinusButton(_ sender: Any) {
        if let controlIndex = tableViewIndex, let tableViewMin = tableViewMinus {
            tableViewPro?.foodQuantitiyMinusPro(indexPath: controlIndex, quantity: tableViewMin)
        }
    }
    
    @IBAction func foodPlusButton(_ sender: Any) {
        if let controlIndex = tableViewIndex, let tableViewPlus = tableViewPlus {
            tableViewPro?.foodQuantitiyPlusPro(indexPath: controlIndex, quantity: tableViewPlus)
        }
    }
    
    
    @IBAction func foodDeleteButton(_ sender: Any) {
        if let controlIndex = tableViewIndex {
            tableViewPro?.foodDeletePro(indexPath: controlIndex)
        }
    }
    
    

}
