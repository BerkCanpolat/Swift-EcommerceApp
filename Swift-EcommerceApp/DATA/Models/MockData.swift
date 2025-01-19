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
    MockData(title: "Delicious Pizzas 10% discounts are waiting for you!", image: "five"),
    MockData(title: "Pizzas with different flavours", image: "three"),
    MockData(title: "20% discount on soup varieties", image: "four"),
    MockData(title: "Eat healthy with forest fruits!", image: "two"),
    MockData(title: "Eat with pleasure with new fruit varieties!", image: "one")
]


let mockCategoriesData = [
    MockData(title: "Fruits", image: "one"),
    MockData(title: "Fruits Plate", image: "two"),
    MockData(title: "Pizza", image: "three"),
    MockData(title: "Soup", image: "four"),
    MockData(title: "All", image: "Category")
]
