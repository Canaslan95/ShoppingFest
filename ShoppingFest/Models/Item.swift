//
//  Item.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import Foundation

class Item {
    
    var id: String!
    var categoryId: String!
    var name: String!
    var description: String!
    var price: Double!
    var imageLinks: [String]!
    
    init() {}
    
    init(dictionary: NSDictionary) {
        
        id = dictionary[kOBJECTID] as?String
        categoryId = dictionary[kCATEGORYID] as? String
        name = dictionary[kNAME] as? String
        description = dictionary[kDESCRIPION] as? String
        price = dictionary[kPRICE] as? Double
        imageLinks = dictionary[kIMAGELINKS] as? [String]
    }
}

func saveItemToFirestore( item: Item) {
    FirebaseReferenece(.Items).document(item.id).setData(itemDictionaryFrom(item: item) as! [String: Any])
}

func itemDictionaryFrom( item: Item) -> NSDictionary {
    
    return NSDictionary(objects: [item.id, item.categoryId, item.name, item.description, item.price, item.imageLinks],
                        forKeys: [kOBJECTID as NSCopying, kCATEGORYID as NSCopying, kNAME as NSCopying, kDESCRIPION as NSCopying, kPRICE as NSCopying, kIMAGELINKS as NSCopying])
}

func downloadItemsFromFirebase(_ withCatgegoryId: String, completion: @escaping (_ itemArray: [Item]) -> Void) {
    var itemArray: [Item] = []
    
    FirebaseReferenece(.Items).whereField(kCATEGORYID, isEqualTo: withCatgegoryId).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else {
            completion(itemArray)
            return
        }
        
        if !snapshot.isEmpty {
            for itemDict in snapshot.documents {
                itemArray.append(Item(dictionary: itemDict.data() as NSDictionary))
            }
        }
        completion(itemArray)
    }
}

func downloadItems(_ withIds: [String], completion: @escaping (_ itemArray: [Item]) ->Void) {
    var count = 0
    var itemArray: [Item] = []
    
    if withIds.count > 0 {
        
        for itemId in withIds {
            FirebaseReferenece(.Items).document(itemId).getDocument { (snapshot, error) in
                
                guard let snapshot = snapshot else {
                    completion(itemArray)
                    return
                }
                
                if snapshot.exists {
                    itemArray.append(Item(dictionary: snapshot.data()! as NSDictionary))
                    count += 1
                } else {
                    completion(itemArray)
                }
                
                if count == withIds.count {
                    completion(itemArray)
                }
            }
        }
    } else {
        completion(itemArray)
    }
    
}













