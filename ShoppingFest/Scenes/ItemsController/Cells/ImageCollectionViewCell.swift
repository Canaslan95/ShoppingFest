//
//  ImageCollectionViewCell.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 8.06.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(image: UIImage) {
        itemImageView.image = image
    }

}
