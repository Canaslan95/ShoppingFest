//
//  Category.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 2.06.2021.
//

import Foundation
import UIKit

class Category {
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(name: String, imageName: String) {
        id = ""
        self.name = name
        self.imageName = imageName
        self.image = UIImage(named: imageName)
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary[kOBJECTID] as! String
        name = dictionary[kNAME] as! String
        image = UIImage(named: dictionary[kIMAGENAME] as? String ?? "")
    }
}
