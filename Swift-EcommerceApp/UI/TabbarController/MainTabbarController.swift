//
//  MainTabbarController.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appereance = UITabBarAppearance()
        
        appereance.backgroundColor = UIColor(named: "tabbarBackground") ?? UIColor.red
        
        changeColor(item: appereance.stackedLayoutAppearance)
        changeColor(item: appereance.inlineLayoutAppearance)
        changeColor(item: appereance.compactInlineLayoutAppearance)
        
        tabBar.standardAppearance = appereance
        tabBar.scrollEdgeAppearance = appereance
    }
    
    
    private func changeColor(item:UITabBarItemAppearance) {
        // Seçili
        item.selected.iconColor = UIColor(named: "tabbarSelectedIconColor")
        item.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "tabbarSelectedTitle") ?? UIColor.gray]
        // Seçili Değil
        item.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "tabbarTitle") ?? UIColor.white]
        item.normal.iconColor = UIColor(named: "tabbarUnSelectedIconColor")
    }

    

}
