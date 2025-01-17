//
//  MockData.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 15.01.2025.
//

import Foundation

struct MockData {
    let title:String
    let image:String
}

let mockLandingData = [
    MockData(title: "Deneme 1 sadads asdas", image: "five"),
    MockData(title: "Deneme 2", image: "three"),
    MockData(title: "Deneme 3", image: "four"),
    MockData(title: "Deneme 4", image: "two"),
    MockData(title: "Deneme 5", image: "one")
]


let mockCategoriesData = [
    MockData(title: "Meyveler", image: "one"),
    MockData(title: "Meyve Tabağı", image: "two"),
    MockData(title: "Pizza", image: "three"),
    MockData(title: "Çorba", image: "four"),
    MockData(title: "All", image: "Category")
]
