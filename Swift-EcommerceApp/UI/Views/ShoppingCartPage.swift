//
//  ShoppingCartPage.swift
//  Swift-EcommerceApp
//
//  Created by Berk Canpolat on 18.01.2025.
//

import UIKit

class ShoppingCartPage: UIViewController {
    
    @IBOutlet weak var foodTotalLabel: UILabel!
    @IBOutlet weak var foodTotalPriceLabel: UILabel!
    
    @IBOutlet weak var selectPaymentOutlet: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectPaymentOutlet.tintColor = UIColor(named: "buttonBasket")
    }
    
    
    
    @IBAction func selectPaymentMethodButton(_ sender: UIButton) {
    }
    
    

}

extension ShoppingCartPage: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! ShoppingCartCell
        cell.selectionStyle = .none
        return cell
    }
}
