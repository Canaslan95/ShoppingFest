//
//  CategoryListTableViewCell.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import UIKit

class CategoryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func generateCell( item: Item) {
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        pricelabel.text = convertToCurrency(item.price)
        pricelabel.adjustsFontSizeToFitWidth = true
        
        if item.imageLinks != nil && item.imageLinks.count > 0 {
            downloadImages(imageUrls: [item.imageLinks.first!]) { (images) in
                self.productImageView.image = images.first as? UIImage
            }
        }
    }
    
}
