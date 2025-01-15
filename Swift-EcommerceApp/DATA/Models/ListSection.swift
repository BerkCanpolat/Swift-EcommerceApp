//
//  ListSection.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import Foundation


enum ListSection {
    case cartLanding([ListItem])
    case cartCategories([ListItem])
    case cartProduct([ListItem])
    
    var items:[ListItem] {
        switch self {
        case .cartLanding(let item),
                .cartCategories(let item),
                .cartProduct(let item):
            return item
        }
    }
    
    var count:Int {
        return items.count
    }
    
    var title:String {
        switch self {
        case .cartLanding:
            return "Landing"
        case .cartCategories:
            return "Categories"
        case .cartProduct:
            return "Product"
        }
    }
}
