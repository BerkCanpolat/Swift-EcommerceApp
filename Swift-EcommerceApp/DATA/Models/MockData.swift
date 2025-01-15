//
//  MockData.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import Foundation

struct MockData {
    static let shared = MockData()
    
    private let land: ListSection = {
        .cartLanding([.init(title: "Bir", image: "one"),
                      .init(title: "İki", image: "two"),
                      .init(title: "Üç", image: "three"),
                      .init(title: "Dört", image: "four"),
                      .init(title: "Beş", image: "five")
                     ])
    }()
    
    private let cat: ListSection = {
        .cartCategories([.init(title: "Bir", image: "one"),
                      .init(title: "İki", image: "two"),
                      .init(title: "Üç", image: "three"),
                      .init(title: "Dört", image: "four"),
                      .init(title: "Beş", image: "five")
                     ])
    }()
    
    private let prod: ListSection = {
        .cartProduct([.init(title: "Bir", image: "one"),
                      .init(title: "İki", image: "two"),
                      .init(title: "Üç", image: "three"),
                      .init(title: "Dört", image: "four"),
                      .init(title: "Beş", image: "five")
                     ])
    }()
    
    var pageData:[ListSection] {
        [land,cat,prod]
    }
}
