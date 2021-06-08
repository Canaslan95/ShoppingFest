//
//  FirebaseCollectionReference.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 2.06.2021.
//

import Foundation
import FirebaseFirestore

enum FirebaseCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReferenece(_ collectionReference: FirebaseCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
