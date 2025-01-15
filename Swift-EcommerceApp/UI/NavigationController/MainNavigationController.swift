//
//  MainNavigationController.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appereance = UINavigationBarAppearance()
        appereance.backgroundColor = UIColor.white
        navigationBar.tintColor = UIColor(named: "navigationBarBuyIcon")
        navigationBar.standardAppearance = appereance
        navigationBar.compactAppearance = appereance
        navigationBar.scrollEdgeAppearance = appereance
                
        
        
    }
}
