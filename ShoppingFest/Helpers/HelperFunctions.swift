//
//  HelperFunctions.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 6.06.2021.
//

import Foundation

func convertToCurrency(_ number: Double) -> String {
   
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    currencyFormatter.locale = Locale(identifier: "TR")
    
    return currencyFormatter.string(from: NSNumber(value: number))!
}
   
   

