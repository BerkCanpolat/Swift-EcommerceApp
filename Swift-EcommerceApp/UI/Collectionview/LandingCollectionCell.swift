//
//  LandingCollectionCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class LandingCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func setup(_ item:MockData) {
        imageView.image = UIImage(named: item.image)
        contentLabel.text = item.title
        
        let randomColor = UIColor(
                hue: CGFloat(drand48()),
                saturation: 0.5, // Daha pastel tonlar için doygunluğu azaltabilirsiniz
                brightness: 0.8,
                alpha: 0.5 // Şeffaflık
            )
        imageView.backgroundColor = randomColor
        imageView.layer.cornerRadius = 10
    }
    
}
