//
//  HomeReusableCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class HomeReusableCell: UICollectionReusableView {
    
    @IBOutlet weak var reusableLabel: UILabel!
    
    func setup(_ title:String) {
        reusableLabel.text = title
    }
    
        
}
