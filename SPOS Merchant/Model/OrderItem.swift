//
//  OrderItem.swift
//  SPOS Merchant
//
//  Created by Tung Nguyen on 8/18/20.
//  Copyright © 2020 Tung Nguyen. All rights reserved.
//

import Foundation

struct OrderItem: Encodable {
    var quantity: Int
    var unitDiscount: Int = 0
    var sellerId: Int
    var sku: String
    var taxOutCode: String = "10"
    var price: Int
    var warranty: Int = 0
    var unitPriceBeforeTax: String = "0.0"
    var rowTotal: Int
    var bizType: String = "Biz"
    var lineItemId: String
    var vatRate: Int = 10
    var unitPrice: String
    var displayName: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case quantity, unitDiscount, sellerId, sku, taxOutCode, price, warranty, unitPriceBeforeTax, rowTotal, bizType, lineItemId, vatRate, unitPrice, displayName, name
    }
}
