//
//  ItemsViewModel.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 8.06.2021.
//

import Foundation
import UIKit

class ItemsViewModel {
    
    var item: Item
    var itemImages: [UIImage] = []
    
    init(item: Item) {
        self.item = item
    }
    
    func downloadPictures(completion: @escaping () -> Void) {
        if item.imageLinks != nil {
            downloadImages(imageUrls: (item.imageLinks)!) { (allImages) in
                if allImages.count > 0 {
                    self.itemImages = allImages as! [UIImage]
                    completion()
                }
            }
        }
    }

}

