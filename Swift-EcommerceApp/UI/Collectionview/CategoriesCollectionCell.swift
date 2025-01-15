//
//  CategoriesCollectionCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class CategoriesCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(_ item:ListItem) {
        imageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    
    
}
