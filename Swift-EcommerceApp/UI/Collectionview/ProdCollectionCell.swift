//
//  ProdCollectionCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit
import Kingfisher

class ProdCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    func setup (_ item:Foods) {
        if let img = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi ?? "ayran.png")") {
            imageView.kf.setImage(with: img)
        }
        prodName.text = item.yemek_adi
        prodPrice.text = item.yemek_fiyat
        
    }
    
    
}
