//
//  ShoppingCartCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 18.01.2025.
//

import UIKit

class ShoppingCartCell: UITableViewCell {
    
    
    @IBOutlet weak var foodSelectButton: UIButton!
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodQuantitiyLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    

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
    }
    
    @IBAction func foodPlusButton(_ sender: Any) {
    }
    
    
    @IBAction func foodDeleteButton(_ sender: Any) {
    }
    
    

}
