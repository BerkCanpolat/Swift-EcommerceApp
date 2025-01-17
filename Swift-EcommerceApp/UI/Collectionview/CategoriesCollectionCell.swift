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
    
    func setup(_ item:MockData) {
        let randomColor = UIColor(
                hue: CGFloat(drand48()),
                saturation: 0.6,
                brightness: 1,
                alpha: 0.6
            )
        imageView.backgroundColor = randomColor
        imageView.image = UIImage(named: item.image)
        titleLabel.text = item.title
        imageView.layer.cornerRadius = 10
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
}
