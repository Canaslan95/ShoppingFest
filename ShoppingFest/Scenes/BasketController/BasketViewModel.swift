//
//  BasketViewModel.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 8.06.2021.
//

import Foundation

class BasketViewModel {
    var baskets: [Basket]?
    var allItems: [Item] = []
    var purchasedItemIds : [String] = []
    
    func getBasketItems(completion: @escaping () -> Void) {
        if baskets != nil {
            allItems = []
            baskets?.forEach({ (basket) in
                downloadItems(basket.itemIds) { (item) in
                    self.allItems.append(contentsOf: item)
                    completion()
                }
            })
        }
    }
}
