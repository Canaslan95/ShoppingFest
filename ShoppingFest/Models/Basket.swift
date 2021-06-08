//
//  File.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 7.06.2021.
//

import Foundation

class Basket {
    
    var id: String!
    var ownerId: String!
    var itemIds: [String]!
    
    init() {
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as? String
        ownerId = _dictionary[kOWNERID] as? String
        itemIds = _dictionary[kITEMIDS] as? [String]
    }
}

func downloadBasketFromFirestore(_ ownerId: String, completion: @escaping (_ basket: [Basket]?)-> Void) {
    FirebaseReferenece(.Basket).whereField(kOWNERID, isEqualTo: ownerId).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else {
            completion(nil)
            return
        }
        if !snapshot.isEmpty && snapshot.documents.count > 0 {
            var basketArray = [Basket]()
            snapshot.documents.forEach { (document) in
                let basket = Basket(_dictionary: document.data() as NSDictionary)
                basketArray.append(basket)
            }
            completion(basketArray)
            
        } else {
            completion(nil)
        }
    }
}

func saveBasketToFirebase(_ basket: Basket) {
    FirebaseReferenece(.Basket).document(basket.id).setData(basketDictionaryFrom(basket: basket) as! [String: Any])
}

func basketDictionaryFrom( basket: Basket) -> NSDictionary {
    return NSDictionary(objects: [basket.id, basket.ownerId, basket.itemIds],
                        forKeys: [kOBJECTID as NSCopying, kOWNERID as NSCopying, kITEMIDS as NSCopying])
}


func updateBasketInFirestore(_ basket: Basket, withValues: [String : Any], completion: @escaping (_ error: Error?) -> Void) {
    
    FirebaseReferenece(.Basket).document(basket.id).updateData(withValues) { (error) in
        completion(error)
    }
}


