//
//  CategoryCollectionViewCell.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 2.06.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyUI()
    }
    
    func applyUI() {
        categoryImageView.contentMode = .scaleAspectFit
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
        categoryLabel.lineBreakMode = .byWordWrapping
        categoryLabel.adjustsFontSizeToFitWidth = true
        containerView.layer.cornerRadius = 8
        containerView.dropShadow(width: 70, height: 70)
    }
    
    func updateUI(category: Category) {
        categoryLabel.text = category.name
        categoryImageView.image = category.image
    }

}
