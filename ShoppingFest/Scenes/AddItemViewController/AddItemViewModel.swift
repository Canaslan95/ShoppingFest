//
//  AddItemCategoryViewModel.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import Foundation
import UIKit

class AddItemViewModel {
    var category: Category
    var itemImages: [UIImage?] = []
    
    init(category: Category) {
        self.category = category
    }
}
