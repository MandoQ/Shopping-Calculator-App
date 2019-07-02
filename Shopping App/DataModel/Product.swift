//
//  Product.swift
//  Shopping App
//
//  Created by Mando Quintana on 6/20/19.
//  Copyright © 2019 Mando Quintana. All rights reserved.
//

import Foundation

struct Product {
    var name: String?
    var price: Double?
    var tax: Double?
    var discount: Double?
    var finalPrice: Double?
    
    var prettyPrice: String? {
        guard let finalPrice = finalPrice else { return nil }
        return "\(finalPrice)"
    }
}
