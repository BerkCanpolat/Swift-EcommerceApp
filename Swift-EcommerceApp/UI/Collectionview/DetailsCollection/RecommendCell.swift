//
//  RecommendCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 17.01.2025.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(_ item:Foods) {
        if let img = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi ?? "ayran.png")") {
            imageView.kf.setImage(with: img)
        }
    }
    
    
}
