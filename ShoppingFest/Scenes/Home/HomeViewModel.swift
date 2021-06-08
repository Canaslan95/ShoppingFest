//
//  HomeViewModel.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 2.06.2021.
//

import Foundation
import UIKit

class HomeViewModel {
    
    var categories: [Category] = []

    func saveCategoryToFirebase(_ category: Category) {
        let id = UUID().uuidString
        category.id = id
        FirebaseReferenece(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String: Any])
    }
    
    func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
        return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
    }

    func downloadCategoriesFromFirebase(completion: @escaping () -> Void) {
        FirebaseReferenece(.Category).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                for categoryDict in snapshot.documents {
                    self.categories.append(Category(dictionary: categoryDict.data() as NSDictionary))
                }
                completion()
            }
        }
    }
    
    // MARK: This function is used for creating categories
    
//    func createCategorySet() {
//        let womenClothing = Category(name: "Women Clothing", imageName: "womenCloth")
//        let electronics = Category(name: "Electronics", imageName: "electronics")
//        let toys = Category(name: "Toys", imageName: "toys")
//        let personalCare = Category(name: "Personal Care", imageName: "personalCare")
//        let petProducts = Category(name: "Pet Products", imageName: "petProducts")
//        let baby = Category(name: "Baby", imageName: "baby")
//
//        let categoryArray = [womenClothing, electronics, toys, personalCare, petProducts, baby]
//
//        for category in categoryArray {
//            saveCategoryToFirebase(category)
//        }
//    }
}
