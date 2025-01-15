//
//  ProdCollectionCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class ProdCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    
    func setup (_ item:ListItem) {
        imageView.image = UIImage(named: item.image)
        
    }
    
    
}
