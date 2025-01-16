//
//  HomeReusableCell.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

protocol FiltersReusableProtocol {
    func filtersFunction(index:IndexPath)
}

class HomeReusableCell: UICollectionReusableView {
    
    @IBOutlet weak var reusableLabel: UILabel!
    @IBOutlet weak var filtersisHidden: UIButton!
    
    var reusableFiltersProtocol:FiltersReusableProtocol?
    var reusableIndexPath:IndexPath?
    
    
    func setup(_ title:String, showButton: Bool = false) {
        reusableLabel.text = title
        filtersisHidden.isHidden = showButton
    }
    
    
    @IBAction func filtersButton(_ sender: UIButton) {
        if let filters = reusableIndexPath {
            reusableFiltersProtocol?.filtersFunction(index: filters)
        } else {
            print("Hata")
        }
    }
    
        
}
