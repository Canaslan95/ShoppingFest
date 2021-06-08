//
//  CategoryListViewModel.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import Foundation

class CategoryListViewModel {
    
    var screenTitle: String?
    var itemArray: [Item] = []
    
    var category: Category {
        didSet {
            screenTitle = category.name
        }
    }
    
    init(category: Category) {
        self.category = category
    }
    
    func loadItems(completion: @escaping () -> Void) {
        downloadItemsFromFirebase(category.id) { (allItems) in
            self.itemArray = allItems
            completion()
        }
    }

}
